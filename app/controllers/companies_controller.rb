class CompaniesController < ApplicationController
  include Pagy::Backend
  before_action :set_company, only: [ :edit, :update, :destroy]

  def index
    if params[:query].present?
      @companies = Company.where("name ILIKE ?", "%#{params[:query]}%")
    elsif params[:category].present?
      @pagy, @companies = pagy(Category.find_by(name: params[:category]).companies)
    else
      @pagy, @companies = pagy(Company.where(status: :active).order(name: :asc))
    end

    respond_to do |format|
      format.html
      format.turbo_stream
      format.json {
        if params[:query].present?
          render json: @companies.as_json(only: [:id, :name])
        else
          # You can handle other JSON responses here if needed.
        end
      }
    end
  end

  def show
    @company = Company.friendly.find(params[:id])
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
  end

  private
  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :url, :email, :about, :user_id, :tech_stack, :logo)
  end
end
