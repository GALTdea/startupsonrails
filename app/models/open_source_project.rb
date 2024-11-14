class OpenSourceProject < ApplicationRecord
  has_many :project_supports, dependent: :destroy
  has_many :companies, through: :project_supports
  has_many :issues, dependent: :destroy

  validates :url, presence: true, format: { with: %r{\Ahttps://github\.com/[a-zA-Z0-9\-_]+/[a-zA-Z0-9\-_]+\z} }
  validates :url, uniqueness: true
  validates :project_type, presence: true
  validates :project_type, inclusion: {
    in: %w[sponsorship contribution maintainer],
    message: '%<value>s is not a valid project type'
  }

  before_validation :set_default_project_type, on: :create
  before_validation :fetch_github_data, on: :create

  def self.project_types
    {
      'sponsorship' => 'sponsorship',
      'contribution' => 'contribution',
      'maintainer' => 'maintainer'
    }
  end

  private

  def set_default_project_type
    self.project_type ||= 'contribution'
  end

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
