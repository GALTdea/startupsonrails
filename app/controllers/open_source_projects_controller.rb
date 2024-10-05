class OpenSourceProjectsController < ApplicationController
  before_action :set_company

  def create
    @open_source_project = @company.open_source_projects.build(open_source_project_params)

    if @open_source_project.save
      render json: @open_source_project, status: :created
    else
      render json: { errors: @open_source_project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = if params[:company_id]
                 Company.find_by!(slug: params[:company_id])
               elsif current_user.company
                 current_user.company
               else
                 raise ActiveRecord::RecordNotFound, 'Company not found'
               end
  end

  def open_source_project_params
    params.require(:open_source_project).permit(:url, :project_type)
  end
end
