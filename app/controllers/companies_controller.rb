class CompaniesController < ApplicationController
  include Pagy::Backend
  before_action :set_company, only: [ :show, :edit, :update, :destroy, :update_status]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :update_status]

  def index
    if params[:query].present?
      @companies = Company.where("name ILIKE ?", "%#{params[:query]}%")
    elsif params[:categories].present?
      # Adjust to handle multiple category IDs
      category_ids = params[:categories].reject(&:blank?) # Ensure no blank IDs are processed
      @pagy, @companies = pagy(Company.joins(:categories).where(categories: { id: category_ids }).distinct)
    else
      @pagy, @companies = pagy(Company.where(status: :active).order(name: :asc))
    end

    respond_to do |format|
      format.html
      format.turbo_stream
      format.json do
        if params[:query].present?
          render json: @companies.as_json(only: [:id, :name])
        else
          # Additional JSON response handling can be done here if needed.
        end
      end
    end
  end


  def show
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
     if user_signed_in?
      @company.user_id = current_user.id
     else
      @company.user_id = 1
     end
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: "Thank you for your submission! The company's profile will be activated upon review." }
        # redirect_to @company
      else
        render :new
      end
    end
  end

  def edit
    authorize @company
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: "Company was successfully updated."
    else
      render :edit
    end
  end

  def update_status
    if @company.update(status: params[:status])
      redirect_to @company, notice: "Company status was successfully updated."
    else
      redirect_to @company, alert: "Company status could not be updated."
    end
  end

  private
  def set_company
    @company = Company.friendly.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :url, :email, :about, :user_id, :tech_stack, :logo)
  end
end
