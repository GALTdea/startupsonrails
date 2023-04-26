class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :url
      t.text :about
      t.string :email
      t.string :location
      t.string :links
      t.text :tech_stack
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
