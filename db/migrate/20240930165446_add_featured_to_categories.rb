class AddFeaturedToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :featured, :boolean
  end
end
