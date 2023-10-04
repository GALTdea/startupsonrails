case Rails.env
when "development"
  puts "Creating users..."
  admin = User.create!( { name: "admin", username: "admin", email: "admin@email.com", password: "password", user_type: :admin } )
  puts "Created #{User.count} users."


  puts "Creating companies..."
  if Company.count == 0
    Company.import_from_csv(admin)
  end
  puts "Created #{Company.count} companies."

  # puts "Creating categories..."
  # category_names = ["cool_cats", "hotwire", "trending", "up_and_comers"]

  # categories = category_names.map do |name|
  #   Category.find_or_create_by!(name: name)
  # end
  # puts "Created #{Category.count} categories."

  puts "Creating categories and adding companies to them..."
    CATEGORIZATIONS = {
      cool_cats: [
        'Basecamp',
        'Costco.com',
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
      ],
      trending: [
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
      ]
    }

    all_companies = CATEGORIZATIONS.values.flatten.uniq.map do |company_name|
      Company.find_by!(name: company_name)
    end

    CATEGORIZATIONS.each do |category_name, company_names|
      puts "Creating #{category_name} category and adding companies to it..."
      Category.find_or_create_by!(name: category_name) do |category|
        companies_for_category = all_companies.select { |company| company_names.include?(company.name) }
        category.companies = companies_for_category
      end
    end

when "production"

end


