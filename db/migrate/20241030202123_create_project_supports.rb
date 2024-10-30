class CreateProjectSupports < ActiveRecord::Migration[7.0]
  def change
    create_table :project_supports do |t|
      t.references :company, null: false, foreign_key: true
      t.references :open_source_project, null: false, foreign_key: true
      t.string :support_type
      t.text :details
      t.datetime :started_at

      t.timestamps
    end
  end
end
