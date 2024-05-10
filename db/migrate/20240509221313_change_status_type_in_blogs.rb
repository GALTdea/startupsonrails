class ChangeStatusTypeInBlogs < ActiveRecord::Migration[7.0]
  def up
    # Convert existing string values to integers
    Blog.find_each do |blog|
      blog.status = case blog.status
                    when 'draft' then 0
                    when 'published' then 1
                    when 'featured' then 2
                    else 0 # default to 'draft' if none of the above
                    end
      blog.save!(validate: false) # save without running validations
    end

    # Remove the default string value temporarily
    change_column_default :blogs, :status, nil

    # Change the column type
    change_column :blogs, :status, :integer, using: 'status::integer'

    # Reset the default as an integer
    change_column_default :blogs, :status, 0
  end

  def down
    # Convert back to strings if needed
    change_column :blogs, :status, :string, using: "CASE status WHEN 0 THEN 'draft' WHEN 1 THEN 'published' WHEN 2 THEN 'featured' END"

    # Reset the default back to 'draft'
    change_column_default :blogs, :status, 'draft'
  end
end
