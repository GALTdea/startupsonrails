# case Rails.env
# when "development"
  puts "Creating users..."
  admin = User.create!( {
    name: "admin",
    username: "admin",
    email: "admin@email.com",
    password: "password",
    user_type: :admin
  })
  puts "Created #{User.count} users."

  puts "Creating companies..."
  if Company.count == 0
    puts "Starting import from CSV..."
    result = Company.import_from_csv(admin)
    puts "Imported #{result[:success_count]} companies."
    puts "Encountered #{result[:error_count]} errors."
    result[:error_messages].each do |error|
      puts "Error: #{error}"
    end
  else
    puts "Companies already exist, skipping import."
  end

  puts "Total companies in database: #{Company.count}"

  puts "Imported #{Company.count} companies."

  puts "Activating all companies in the database..."
  Company.all.each do |company|
    company.update!(status: :active)
  end

  puts "Creating categories and adding companies to them..."
  CATEGORIZATIONS = {
    top_rails_companies: [
      'shopify',
      'github',
      'basecamp',
      'airbnb',
      'etsy',
      'hulu',
      'bloomberg',
      'zendesk',
      'crunchbase',
      'soundcloud',
      'fiverr'
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
      'gorails',
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
      'gorails',
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
      'gorails',
    ],
    tooling: [
      'appsignal',
      'github',
      'gitlab',
      'heroku',
      'jumpstart',
      'appsignal',
      'github',
      'gitlab',
      'heroku',
      'jumpstart',
    ],
    top_bootstraped: [
      'shopify',
      'github',
      'basecamp',
      'airbnb',
      'crunchbase',
      'etsy',
      'hulu',
      'bloomberg',
      'soundcloud',
      'zendesk',
      'fiverr'
    ],
    # top_contribuitors: [
    #   'hey.com',
    #   'beehiiv',
    #   'gitlab',
    #   'heroku',
    #   'gorails',
    #   'hey.com',
    #   'beehiiv',
    #   'gitlab',
    #   'heroku',
    #   'gorails',
    # ],
    # top_hotwire_use: [
    #   'appsignal',
    #   'github',
    #   'gitlab',
    #   'heroku',
    #   'jumpstart',
    #   'appsignal',
    #   'github',
    #   'gitlab',
    #   'heroku',
    #   'jumpstart',
    # ],
    # top_jr_friendly: [
    #   'appsignal',
    #   'github',
    #   'gitlab',
    #   'heroku',
    #   'jumpstart',
    #   'appsignal',
    #   'github',
    #   'gitlab',
    #   'heroku',
    #   'jumpstart',
    # ],
    top_tooling: [
      'appsignal',
      'github',
      'gitlab',
      'heroku',
      'jumpstart',
      'appsignal',
      'github',
      'gitlab',
      'heroku',
      'jumpstart',
    ],
    top_indy: [
      'appsignal',
      'github',
      'gitlab',
      'heroku',
      'jumpstart',
      'appsignal',
      'github',
      'gitlab',
      'heroku',
      'jumpstart',
    ],
    "Los Angeles" => [
      'appsignal',
      'github',
      'gitlab',
      'heroku',
      'jumpstart',
      'appsignal',
      'github',
      'gitlab',
      'heroku',
      'jumpstart',
      'appsignal',
    ],
    "New York" => [
    'appsignal',
    'github',
    'gitlab',
    'heroku',
    'jumpstart',
    'appsignal',
    'github',
    'gitlab',
    'heroku',
    'jumpstart',
    'appsignal',
    ],
    "San Francisco" => [
    'appsignal',
    'github',
    'gitlab',
    'heroku',
    'jumpstart',
    'appsignal',
    'github',
    'gitlab',
    'heroku',
    'jumpstart',
    'appsignal',
    ],
    "London" => [
    'appsignal',
    'github',
    'gitlab',
    'heroku',
    'jumpstart',
    'appsignal',
    'github',
    'gitlab',
    'heroku',
    'jumpstart',
    'appsignal',
    ],
    # "Berlin" => [
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # ],
    # "Tokyo" => [
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # ],
    # "Sydney" => [
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # ],
    # "Toronto" => [
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # ],
    # "Paris" => [
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # ],
    # "Singapore" => [
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # ],
    # "São Paulo" => [
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # 'github',
    # 'gitlab',
    # 'heroku',
    # 'jumpstart',
    # 'appsignal',
    # ]


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

# when "production"

# end
