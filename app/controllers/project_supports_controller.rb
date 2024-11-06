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
    project_name = @project_support.open_source_project.url.split('/').last
    support_type = @project_support.support_type

    if @project_support.destroy
      success_message = "#{project_name} has been removed from #{support_type} projects"

      respond_to do |format|
        format.html do
          redirect_to company_project_supports_path(@company),
                      notice: success_message
        end
        format.turbo_stream do
          render turbo_stream: turbo_stream.multi(
            turbo_stream.remove("project_support_#{@project_support.id}"),
            turbo_stream.append('flash',
                                partial: 'shared/flash',
                                locals: {
                                  message: success_message,
                                  type: 'success'
                                })
          )
        end
      end
    else
      error_message = 'Unable to remove project support'
      respond_to do |format|
        format.html do
          redirect_to company_project_supports_path(@company),
                      alert: error_message
        end
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('flash',
                                                   partial: 'shared/flash',
                                                   locals: {
                                                     message: error_message,
                                                     type: 'danger'
                                                   })
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
