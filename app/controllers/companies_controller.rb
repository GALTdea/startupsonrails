class CompaniesController < ApplicationController
  include Pagy::Backend
  before_action :set_company, only: %i[edit update destroy update_status]
  before_action :authenticate_user!, only: %i[new edit update destroy update_status]

  def index
    @companies = Company.where(status: :active)

    if params[:location].present?
      @companies = @companies.search_by_location(params[:location])
      @filtered_by_location = true
    end

    if params[:query].present?
      @companies = @companies.where('name ILIKE ? OR location ILIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    elsif params[:location].present?
      @companies = @companies.where('location ILIKE ?', "%#{params[:location]}%")
    elsif params[:category_id].present?
      @companies = @companies.joins(:categories).where(categories: { id: params[:category_id] }).distinct
    elsif params[:category_ids].present?
      category_ids = Array(params[:category_ids]).reject(&:blank?)
      @companies = @companies.joins(:categories).where(categories: { id: category_ids }).distinct
    elsif params[:filter] == 'duplicates'
      duplicate_names_urls = Company.duplicates
      @companies = Company.where(name: duplicate_names_urls.map(&:first), url: duplicate_names_urls.map(&:last))
    end

    @pagy, @companies = pagy(@companies.order(name: :asc))

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          'companies_list',
          partial: 'companies/list',
          locals: { companies: @companies, pagy: @pagy }
        )
      end
      format.json do
        render json: @companies.as_json(only: %i[id name location])
      end
    end
  end

  def show
    # This query:
    # 1. Uses includes() to eager load project_supports and their associated open_source_projects
    #    to avoid N+1 queries when accessing these associations
    # 2. Uses friendly.find() to look up the company by its friendly ID (slug) instead of numeric ID
    # 3. Finds a single company record matching the ID/slug from params
    @company = Company.includes(project_supports: :open_source_project)
                      .friendly.find(params[:id])

    @sponsored_projects = @company.open_source_projects
                                  .joins(:project_supports)
                                  .where(project_supports: { support_type: 'sponsorship' })

    @contributed_projects = @company.open_source_projects
                                    .joins(:project_supports)
                                    .where(project_supports: { support_type: 'contribution' })

    @issues = @company.issues
    @page_title = @company.name
    @page_description = @company.about
    @page_image_url = @company.logo.attached? ? url_for(@company.logo) : nil
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.user_id = if user_signed_in?
                         current_user.id
                       else
                         1
                       end
    respond_to do |format|
      if @company.save
        format.html do
          redirect_to @company,
                      notice: "Thank you for your submission! The company's profile will be activated upon review."
        end
        # redirect_to @company
      else
        render :new
      end
    end
  end

  def destroy
    # authorize @company
    if @company.destroy
      redirect_to companies_path, notice: 'Company was successfully deleted.', turbo_stream: false
    else
      redirect_to @company, alert: 'Failed to delete the company.', turbo_stream: false
    end
  end

  def edit
    authorize @company
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  def update_status
    authorize @company
    if @company.update(status: params[:status])
      redirect_to @company, notice: 'Company status was successfully updated.'
    else
      redirect_to @company, alert: 'Company status could not be updated.'
    end
  end

  def search
    @companies = Company.where('name ILIKE ?', "%#{params[:query]}%").limit(10)
    render json: @companies.map { |company| { id: company.id, name: company.name } }
  end

  def export
    csv_data = Company.export_to_csv
    send_data csv_data,
              filename: "companies_export_#{Time.now.strftime('%Y%m%d_%H%M%S')}.csv",
              type: 'text/csv',
              disposition: 'attachment'
  end

  private

  def set_company
    @company = Company.includes(:open_source_projects).friendly.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :url, :email, :about, :user_id, :tech_stack, :logo, :location,
                                    :employee_count, :company_type, :year_founded, :revenue)
  end
end
