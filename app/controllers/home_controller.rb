class HomeController < ApplicationController
  def show
    @categories = Category.showcased

    @companies_by_category = {}
    @categories.each do |category|
      @companies_by_category[category.name] = category.companies
    end
  end
end



puts "Creating categories and adding companies to them..."
CATEGORIZATIONS = {
  top_rails_companies: [
    'Shopify',
    'Github',
    'Basecamp',
    'Airbnb',
    'Crunchbase',
  ],
  trending: [
    'hey.com',
    'Beehiiv',
    'GitLab',
    'Heroku',
    'GoRails',
  ]
}

all_companies = CATEGORIZATIONS.values.flatten.uniq.map do |company_name|
  begin
    Company.find_by!(name: company_name)
  rescue ActiveRecord::RecordNotFound => e
    puts "No company found with name: #{company_name}"
    nil  # return nil so this element is not included in all_companies
  end
end.compact  # remove any nil values from the array

CATEGORIZATIONS.each do |category_name, company_names|
  puts "Creating #{category_name} category and adding companies to it..."
  Category.find_or_create_by!(name: category_name) do |category|
    companies_for_category = all_companies.select { |company| company_names.include?(company.name) }
    category.companies = companies_for_category
    puts "Created  #{category_name} category with #{category.companies.count} companies. "
  end
end