class Contribution < ApplicationRecord
  belongs_to :company
  validates :github_url, presence: true, format: { with: %r{\Ahttps://github\.com/[^/]+/[^/]+\z}, message: 'must be a valid GitHub repository URL' }

  before_save :fetch_github_data

  private

  def fetch_github_data
    repo_name = github_url.split('/')[-2..-1].join('/')
    # debugger
    github_data = GithubService.new(repo_name).fetch_repo_data

    self.name = github_data[:name]
    self.description = github_data[:description]
    self.stars = github_data[:stargazers_count]
    self.forks = github_data[:forks_count]
    self.icon_url = github_data[:owner][:avatar_url]
  end
end
