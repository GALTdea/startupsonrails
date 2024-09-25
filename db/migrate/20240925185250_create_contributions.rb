class CreateContributions < ActiveRecord::Migration[7.0]
  def change
    create_table :contributions do |t|
      t.string :name
      t.text :description
      t.string :github_url
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
