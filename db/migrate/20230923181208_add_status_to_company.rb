class AddStatusToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :status, :integer, default: 0
  end
end
