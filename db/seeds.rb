# case Rails.env
# when "development"
puts 'Creating users...'
admin = User.find_or_initialize_by(email: 'admin@email.com', username: 'admin')
admin.assign_attributes({
                          name: 'admin',
                          password: 'password',
                          user_type: :admin
                        })
admin.save!

puts 'Admin user created or updated.'

puts 'Creating companies...'
if Company.count == 0
  puts 'Starting import from CSV...'
  result = Company.import_from_csv
  puts "Imported #{result[:success_count]} companies."
  puts "Encountered #{result[:error_count]} errors."
  result[:error_messages].each do |error|
    puts "Error: #{error}"
  end
else
  puts 'Companies already exist, skipping import.'
end

puts "Total companies in database: #{Company.count}"

puts "Imported #{Company.count} companies."

puts 'Activating all companies in the database...'
Company.find_each do |company|
  company.update!(status: :active)
rescue ActiveRecord::RecordInvalid => e
  puts "Warning: Could not update company '#{company.name}': #{e.message}"
end

puts 'Creating categories and adding companies to them...'
CATEGORIZATIONS = {
  top_rails_companies: %w[
    shopify
    github
    basecamp
    airbnb
    etsy
    hulu
    bloomberg
    zendesk
    crunchbase
    soundcloud
    fiverr
  ],
  trending: [
    'hey.com',
    'beehiiv',
    'gitlab',
    'heroku',
    'gorails',
    'hey.com',
    'beehiiv',
    'gitlab',
    'heroku',
    'gorails'
  ],
  hotwire: [
    'basecamp',
    'costco.com',
    'gitlab',
    'heroku',
    'gorails',
    'basecamp',
    'costco.com',
    'gitlab',
    'heroku',
    'gorails'
  ],
  up_and_comers: [
    'basecamp',
    'costco.com',
    'gitlab',
    'heroku',
    'gorails',
    'basecamp',
    'costco.com',
    'gitlab',
    'heroku',
    'gorails'
  ],
  tooling: %w[
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
    github
    gitlab
    heroku
    jumpstart
  ],
  top_bootstraped: %w[
    shopify
    github
    basecamp
    airbnb
    crunchbase
    etsy
    hulu
    bloomberg
    soundcloud
    zendesk
    fiverr
  ],
  top_tooling: %w[
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
    github
    gitlab
    heroku
    jumpstart
  ],
  top_indy: %w[
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
    github
    gitlab
    heroku
    jumpstart
  ],
  'Los Angeles' => %w[
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
  ],
  'New York' => %w[
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
  ],
  'San Francisco' => %w[
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
  ],
  'London' => %w[
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
    github
    gitlab
    heroku
    jumpstart
    appsignal
  ]
}

all_companies = CATEGORIZATIONS.values.flatten.uniq.map do |company_name|
  Company.find_by!(name: company_name)
rescue ActiveRecord::RecordNotFound => e
  puts "No company found with name: #{company_name}"
  nil # return nil so this element is not included in all_companies
end.compact # remove any nil values from the array

CATEGORIZATIONS.each do |category_name, company_names|
  puts "Creating #{category_name} category and adding companies to it..."
  Category.find_or_create_by!(name: category_name) do |category|
    companies_for_category = all_companies.select { |company| company_names.include?(company.name) }
    category.companies = companies_for_category
    puts "Created  #{category_name} category with #{category.companies.count} companies. "
  end
end

# when "production"

# end

# Set featured categories
featured_category_names = ['top_rails_companies', 'trending', 'hotwire', 'tooling', 'Los Angeles', 'New York']

featured_category_names.each do |category_name|
  category = Category.find_by(name: category_name)
  if category
    category.update(featured: true)
    puts "Set #{category_name} as featured."
  else
    puts "Category #{category_name} not found."
  end
end

puts 'Featured categories have been set.'
