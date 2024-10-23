class IssuesController < ApplicationController
  before_action :set_company
  before_action :set_issue, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @issues = @company.issues
  end

  def show
  end

  def new
    @issue = Issue.new
    @open_source_projects = @company.open_source_projects
  end

  def create
    @issue = @company.issues.new(issue_params)
    @open_source_project = @company.open_source_projects.find(params[:issue][:open_source_project_id])
    @issue.open_source_project = @open_source_project

    # Apply GitHub issue data if provided
    apply_github_issue_data if params[:issue][:github_issue].present?

    if @issue.save
      redirect_to company_issue_path(@company, @issue), notice: 'Issue was successfully created.'
    else
      @open_source_projects = @company.open_source_projects
      render :new
    end
  end

  def edit
    @open_source_projects = @company.open_source_projects
  end

  def update
    if @issue.update(issue_params)
      redirect_to company_issue_path(@company, @issue), notice: 'Issue was successfully updated.'
    else
      @open_source_projects = @company.open_source_projects
      render :edit
    end
  end

  def destroy
    @issue.destroy
    redirect_to company_issues_path(@company), notice: 'Issue was successfully destroyed.'
  end

  def fetch_github_issues
    @open_source_project = @company.open_source_projects.find(params[:open_source_project_id])
    client = Octokit::Client.new(access_token: Rails.application.credentials.github[:access_token])
    repo_name = @open_source_project.url.split('github.com/').last
    issues = client.issues(repo_name)
    render json: issues.map { |issue| { id: issue.number, title: issue.title, html_url: issue.html_url } }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  rescue Octokit::Error => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Company not found' }, status: :not_found
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:title, :description, :github_url, :open_source_project_id)
  end

  def apply_github_issue_data
    github_issue_data = JSON.parse(params[:issue][:github_issue])
    @issue.title = github_issue_data['title'] if @issue.title.blank?
    @issue.github_url = github_issue_data['html_url'] if @issue.github_url.blank?
  end

  def authorize_user
    # Implement your authorization logic here
  end
end
