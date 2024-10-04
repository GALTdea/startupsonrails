class CreateOpenSourceProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :open_source_projects do |t|
      t.string :name
      t.text :description
      t.string :project_type
      t.string :url
      t.string :icon_url
      t.integer :stars
      t.integer :forks
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
