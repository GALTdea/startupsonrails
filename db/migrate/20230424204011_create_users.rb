class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :user_type
      t.string :admin?

      t.timestamps
    end
  end
end
