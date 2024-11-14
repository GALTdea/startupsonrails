class OpenSourceProjectsController < ApplicationController
  before_action :set_project, only: [:destroy]
  before_action :authorize_admin, only: %i[new create destroy]

  def index
    @open_source_projects = OpenSourceProject.all.order(stars: :desc)
  end

  def new
    @open_source_project = OpenSourceProject.new
  end

  def create
    @open_source_project = OpenSourceProject.new(open_source_project_params)

    if @open_source_project.save
      redirect_to open_source_projects_path, notice: 'Open Source Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @open_source_project.destroy
    redirect_to open_source_projects_path, notice: 'Project was successfully removed.'
  end

  private

  def set_project
    @open_source_project = OpenSourceProject.find(params[:id])
  end

  def authorize_admin
    return if current_user&.admin?

    redirect_to open_source_projects_path, alert: 'Unauthorized access'
  end

  def open_source_project_params
    params.require(:open_source_project).permit(:url, :project_type)
  end
end
