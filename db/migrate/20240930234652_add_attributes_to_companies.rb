class AddAttributesToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :employee_count, :integer
    add_column :companies, :company_type, :string
    add_column :companies, :year_founded, :integer
    add_column :companies, :hiring, :string
    add_column :companies, :revenue, :string
    add_column :companies, :people, :text
  end
end
