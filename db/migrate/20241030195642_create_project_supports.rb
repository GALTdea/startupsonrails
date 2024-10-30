class CreateProjectSupports < ActiveRecord::Migration[7.0]
  def change
    # Remove company_id from open_source_projects
    remove_reference :open_source_projects, :company, foreign_key: true

    # The generator created this part automatically
    create_table :project_supports do |t|
      t.references :company, null: false, foreign_key: true
      t.references :open_source_project, null: false, foreign_key: true
      t.string :support_type, null: false
      t.text :details
      t.datetime :started_at

      t.timestamps

      # Add this index manually
      t.index %i[company_id open_source_project_id support_type],
              unique: true,
              name: 'index_project_supports_uniqueness'
    end
  end
end
