class OpenSourceProject < ApplicationRecord
  belongs_to :company

  validates :url, presence: true, format: { with: %r{\Ahttps://github\.com/[a-zA-Z0-9\-_]+/[a-zA-Z0-9\-_]+\z} }
  validates :project_type, presence: true, inclusion: { in: %w[contribution sponsorship] }

  before_validation :fetch_github_data, on: :create

  private

  def fetch_github_data
    return unless url.present?

    repo_name = url.split('github.com/').last
    repo_data = Octokit::Client.new.repository(repo_name)

    self.name = repo_data.name
    self.description = repo_data.description
    self.icon_url = repo_data.owner.avatar_url
    self.stars = repo_data.stargazers_count
    self.forks = repo_data.forks_count
  rescue Octokit::Error => e
    errors.add(:url, "Unable to fetch GitHub data: #{e.message}")
  end
end
