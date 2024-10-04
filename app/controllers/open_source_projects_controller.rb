class OpenSourceProjectsController < ApplicationController
  before_action :set_company
  before_action :set_open_source_project, only: %i[update destroy]

  def index
    @open_source_projects = @company.open_source_projects
  end

  def create
    @open_source_project = @company.open_source_projects.build(open_source_project_params)
    if @open_source_project.save
      render json: @open_source_project, status: :created
    else
      render json: { errors: @open_source_project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @open_source_project.update(open_source_project_params)
      render json: @open_source_project
    else
      render json: @open_source_project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @open_source_project.destroy
    head :no_content
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_open_source_project
    @open_source_project = @company.open_source_projects.find(params[:id])
  end

  def open_source_project_params
    params.require(:open_source_project).permit(:url, :project_type)
  end
end
