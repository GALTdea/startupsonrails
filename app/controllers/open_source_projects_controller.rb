class OpenSourceProjectsController < ApplicationController
  before_action :set_company
  before_action :authorize_user, only: [:create]

  def create
    @project = @company.open_source_projects.build(open_source_project_params)
    authorize @project
    if @project.save
      render json: @project, status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = current_user.company
  end

  def open_source_project_params
    params.require(:open_source_project).permit(:url, :project_type)
  end

  def authorize_user
    authorize OpenSourceProject
  end
end
