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
    Company.import_from_csv(admin)
  end
  puts "Imported #{Company.count} companies."

  puts "Creating categories and adding companies to them..."
  CATEGORIZATIONS = {
    top_rails_companies: [
      'Shopify',
      'Github',
      'Basecamp',
      'Airbnb',
      'Etsy',
      'Hulu',
      'bloomberg',
      'Zendesk',
      'Crunchbase',
      'SoundCloud',
      'Fiverr'
    ],
    trending: [
      'hey.com',
      'Beehiiv',
      'GitLab',
      'Heroku',
      'GoRails',
      'hey.com',
      'Beehiiv',
      'GitLab',
      'Heroku',
      'GoRails',
    ],
    hotwire: [
      'Basecamp',
      'Costco.com',
      'GitLab',
      'Heroku',
      'GoRails',
      'Basecamp',
      'Costco.com',
      'GitLab',
      'Heroku',
      'GoRails',
    ],
    up_and_comers: [
      'Basecamp',
      'Costco.com',
      'GitLab',
      'Heroku',
      'GoRails',
      'Basecamp',
      'Costco.com',
      'GitLab',
      'Heroku',
      'GoRails',
    ],
    tooling: [
      'AppSignal',
      'Github',
      'GitLab',
      'Heroku',
      'Jumpstart',
      'AppSignal',
      'Github',
      'GitLab',
      'Heroku',
      'Jumpstart',
    ],
    top_bootstraped: [
      'Shopify',
      'Github',
      'Basecamp',
      'Airbnb',
      'Crunchbase',
      'Etsy',
      'Hulu',
      'bloomberg',
      'SoundCloud',
      'Zendesk',
      'Fiverr'
    ],
    # top_contribuitors: [
    #   'hey.com',
    #   'Beehiiv',
    #   'GitLab',
    #   'Heroku',
    #   'GoRails',
    #   'hey.com',
    #   'Beehiiv',
    #   'GitLab',
    #   'Heroku',
    #   'GoRails',
    # ],
    # top_hotwire_use: [
    #   'AppSignal',
    #   'Github',
    #   'GitLab',
    #   'Heroku',
    #   'Jumpstart',
    #   'AppSignal',
    #   'Github',
    #   'GitLab',
    #   'Heroku',
    #   'Jumpstart',
    # ],
    # top_jr_friendly: [
    #   'AppSignal',
    #   'Github',
    #   'GitLab',
    #   'Heroku',
    #   'Jumpstart',
    #   'AppSignal',
    #   'Github',
    #   'GitLab',
    #   'Heroku',
    #   'Jumpstart',
    # ],
    top_tooling: [
      'AppSignal',
      'Github',
      'GitLab',
      'Heroku',
      'Jumpstart',
      'AppSignal',
      'Github',
      'GitLab',
      'Heroku',
      'Jumpstart',
    ],
    top_indy: [
      'AppSignal',
      'Github',
      'GitLab',
      'Heroku',
      'Jumpstart',
      'AppSignal',
      'Github',
      'GitLab',
      'Heroku',
      'Jumpstart',
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

# when "production"

# end
