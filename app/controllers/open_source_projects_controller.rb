class OpenSourceProjectsController < ApplicationController
  # before_action :set_company
  before_action :set_project, only: [:destroy]
  before_action :authorize_user, only: [:destroy]

  def new
    @open_source_project = OpenSourceProject.new
  end

  def create
    Rails.logger.debug "Params received: #{params.inspect}"
    Rails.logger.debug "Permitted params: #{open_source_project_params.inspect}"

    @open_source_project = OpenSourceProject.new(open_source_project_params)
    Rails.logger.debug "Valid? #{@open_source_project.valid?}"
    Rails.logger.debug "Errors: #{@open_source_project.errors.full_messages}" if @open_source_project.invalid?

    if @open_source_project.save
      redirect_to admin_companies_path, notice: 'Open Source Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      render json: { success: true }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  def index
    @company = Company.friendly.find(params[:company_id])
    @open_source_projects = @company.open_source_projects
  end

  def new
    @open_source_project = OpenSourceProject.new
  end

  private

  def set_project
    @project = @company.open_source_projects.find(params[:id])
  end

  def authorize_user
    return if current_user && (current_user.admin? || current_user == @company.user)

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def open_source_project_params
    params.require(:open_source_project).permit(:name, :description, :url, :project_type, :icon_url, :stars, :forks)
  end
end
