class NormalizeCompanyNames < ActiveRecord::Migration[7.0]
  def up
    Company.find_each do |company|
      normalized_name = company.name.downcase.strip
      company.update(name: normalized_name)
    end
  end
end
