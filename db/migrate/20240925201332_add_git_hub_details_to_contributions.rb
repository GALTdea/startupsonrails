class AddGitHubDetailsToContributions < ActiveRecord::Migration[7.0]
  def change
    add_column :contributions, :stars, :integer
    add_column :contributions, :forks, :integer
    add_column :contributions, :icon_url, :string
  end
end
