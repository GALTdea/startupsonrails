class RemoveCompanyFromIssues < ActiveRecord::Migration[7.0]
  def change
    remove_reference :issues, :company, foreign_key: true, index: true
  end
end
