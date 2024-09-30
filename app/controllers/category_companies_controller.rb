class CategoryCompaniesController < ApplicationController
  before_action :set_category

  def create
    company = if params[:company_id].present?
                Company.find(params[:company_id])
              else
                Company.find_or_create_by(name: params[:company_name])
              end

    if @category.companies << company
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('companies_list', partial: 'categories/company',
                                                                     locals: { company:, category: @category })
        end
        format.html { redirect_to @category, notice: 'Company was successfully added to the category.' }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('add_company_form', partial: 'categories/add_company_form',
                                                                        locals: { category: @category })
        end
        format.html { redirect_to @category, alert: 'Failed to add company to the category.' }
      end
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end
end
