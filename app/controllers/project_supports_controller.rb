class ProjectSupportsController < ApplicationController
  before_action :set_company, only: %i[index new create]

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

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def project_support_params
    # params.require(:project_support).permit(:company_id, :support_type)
    params.require(:project_support).permit(:support_type)
  end

  def open_source_project_params
    params.require(:open_source_project).permit(:url)
  end
end
