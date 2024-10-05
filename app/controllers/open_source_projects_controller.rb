class OpenSourceProjectsController < ApplicationController
  before_action :set_company

  def create
    @project = @company.open_source_projects.build(open_source_project_params)
    if @project.save
      render json: @project, status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def open_source_project_params
    params.require(:open_source_project).permit(:url, :project_type)
  end
end
