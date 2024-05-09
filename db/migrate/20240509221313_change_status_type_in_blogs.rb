class ChangeStatusTypeInBlogs < ActiveRecord::Migration[7.0]
  def up
    change_column_default :blogs, :status, nil

    Blog.where(status: 'draft').update_all(status: 0)
    Blog.where(status: 'published').update_all(status: 1)
    Blog.where(status: 'featured').update_all(status: 2)

    change_column :blogs, :status, :integer, using: 'status::integer'

    change_column_default :blogs, :status, 0
  end

  def down
    change_column :blogs, :status, :string, using: 'CASE status WHEN 0 THEN \'draft\' WHEN 1 THEN \'published\' WHEN 2 THEN \'featured\' END'

    change_column_default :blogs, :status, 'draft'
  end
end
