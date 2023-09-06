class CategoryCompaniesController < ApplicationController
  before_action :set_category

  def create
    company = Company.find(params[:company_id])
    @category.companies << company

    redirect_to category_path(@category), notice: 'Company was successfully added.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end
end
