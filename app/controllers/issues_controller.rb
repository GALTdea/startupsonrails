class IssuesController < ApplicationController
  before_action :set_open_source_project
  before_action :set_issue, only: %i[show edit update destroy]

  def index
    @issues = @open_source_project.issues
  end

  def show
  end

  def new
    @issue = @open_source_project.issues.build
  end

  def create
    @issue = @open_source_project.issues.build(issue_params)
    if @issue.save
      redirect_to [@open_source_project.company, @open_source_project, @issue],
                  notice: 'Issue was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @issue.update(issue_params)
      redirect_to [@open_source_project.company, @open_source_project, @issue],
                  notice: 'Issue was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @issue.destroy
    redirect_to company_open_source_project_issues_path(@open_source_project.company, @open_source_project),
                notice: 'Issue was successfully destroyed.'
  end

  private

  def set_open_source_project
    @open_source_project = OpenSourceProject.find(params[:open_source_project_id])
  end

  def set_issue
    @issue = @open_source_project.issues.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:title, :description, :github_url)
  end
end
