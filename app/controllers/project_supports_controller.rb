class ProjectSupportsController < ApplicationController
  before_action :set_company, only: %i[index new create]
  before_action :set_project_support, only: [:destroy]
  before_action :authorize_destroy, only: [:destroy]

  def index
    @project_supports = @company.project_supports.includes(:open_source_project)
  end

  def new
    @project_support = @company.project_supports.new
    @open_source_project = OpenSourceProject.new
  end

  def create
    @project_support = @company.project_supports.new(project_support_params)
    @open_source_project = OpenSourceProject.find_or_create_by!(
      url: open_source_project_params[:url]
    )

    @project_support.open_source_project = @open_source_project

    respond_to do |format|
      if @project_support.save
        project_name = @open_source_project.url.split('/').last
        success_message = "Successfully added #{project_name} as a #{@project_support.support_type} project"

        format.html { redirect_to company_project_supports_path(@company), notice: success_message }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
    @company = @project_support.company

    if @project_support.destroy
      respond_to do |format|
        format.html do
          redirect_to company_project_supports_path(@company),
                      notice: 'Project support was successfully removed.'
        end
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html do
          redirect_to company_project_supports_path(@company),
                      alert: 'Unable to remove project support.'
        end
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('flash',
                                                   partial: 'shared/flash',
                                                   locals: { message: 'Unable to remove project support',
                                                             type: 'danger' })
        end
      end
    end
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_project_support
    @project_support = ProjectSupport.find(params[:id])
  end

  def authorize_destroy
    return if current_user&.admin? || current_user == @project_support.company.user

    redirect_to company_project_supports_path(@project_support.company),
                alert: 'You are not authorized to perform this action'
  end

  def project_support_params
    # params.require(:project_support).permit(:company_id, :support_type)
    params.require(:project_support).permit(:support_type)
  end

  def open_source_project_params
    params.require(:open_source_project).permit(:url)
  end
end
