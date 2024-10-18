class AddOpenSourceProjectToIssues < ActiveRecord::Migration[7.0]
  def change
    add_reference :issues, :open_source_project, foreign_key: true, null: true
  end
end
