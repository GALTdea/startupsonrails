class OpenSourceProjectsController < ApplicationController
  before_action :set_company
  before_action :set_project, only: [:destroy]
  before_action :authorize_user, only: [:destroy]

  def create
    @open_source_project = @company.open_source_projects.build(open_source_project_params)

    if @open_source_project.save
      render json: @open_source_project, status: :created
    else
      render json: { errors: @open_source_project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      render json: { success: true }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_project
    @project = @company.open_source_projects.find(params[:id])
  end

  def authorize_user
    return if current_user && (current_user.admin? || current_user == @company.user)

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def open_source_project_params
    params.require(:open_source_project).permit(:url, :project_type)
  end
end
