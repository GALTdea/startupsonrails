class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :published_at
      t.string :category
      t.references :user, null: false, foreign_key: true
      t.string :status, default: 'draft'

      t.timestamps
    end
    add_index :blogs, :title
  end
end
