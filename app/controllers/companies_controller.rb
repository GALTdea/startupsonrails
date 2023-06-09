class CompaniesController < ApplicationController
  include Pagy::Backend
  before_action :set_company, only: [ :edit, :update, :destroy]
  def index
    @pagy, @companies = pagy(Company.all, items: 15)
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
    params.require(:company).permit(:name, :url, :email, :about, :user_id, :tech_stack)
  end
end
