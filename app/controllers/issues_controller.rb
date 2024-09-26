class IssuesController < ApplicationController
  before_action :set_company
  before_action :set_issue, only: %i[edit update destroy]

  def index
    @issues = @company.issues
  end

  def new
    @issue = @company.issues.build
  end

  def create
    @issue = @company.issues.build(issue_params)
    if @issue.save
      redirect_to company_issues_path(@company), notice: 'Issue was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @issue.update(issue_params)
      redirect_to company_issues_path(@company), notice: 'Issue was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @issue.destroy
    redirect_to company_issues_path(@company), notice: 'Issue was successfully destroyed.'
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_issue
    @issue = @company.issues.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:title, :description, :github_url)
  end
end
