require 'net/http'

class GithubService
  BASE_URL = 'https://api.github.com/repos/'

  def initialize(repo_name)
    @repo_name = repo_name
  end

  def fetch_repo_data
    uri = URI(BASE_URL + @repo_name)
    response = Net::HTTP.get(uri)
    JSON.parse(response, symbolize_names: true)
  end
end
