class RemoveCompanyFromOpenSourceProjects < ActiveRecord::Migration[7.0]
  def change
    remove_reference :open_source_projects, :company, foreign_key: true
  end
end
