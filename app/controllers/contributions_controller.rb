class ContributionsController < ApplicationController
  before_action :set_company
  before_action :authenticate_user!, only: [:create]
  before_action :check_admin, only: [:create]

  def create
    @contribution = @company.contributions.new(contribution_params)
    if @contribution.save
      redirect_to @company, notice: 'Contribution was successfully added.'
    else
      redirect_to @company, alert: @contribution.errors.full_messages.join(', ')
    end
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def contribution_params
    params.require(:contribution).permit(:github_url)
  end

  def check_admin
    return if current_user.admin?

    redirect_to @company, alert: 'You are not authorized to perform this action.'
  end
end
