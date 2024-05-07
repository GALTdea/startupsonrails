namespace :data_update do
  desc "Associate companies with categories based on normalized names"
  task associate_companies: :environment do
    begin
      Category::CATEGORY_COMPANY_MAP.each do |category_name, company_names|
        category = Category.find_or_create_by(name: category_name.downcase.strip)
        company_names.each do |company_name|
          normalized_name = company_name.downcase.strip
          begin
            company = Company.find_or_create_by(name: normalized_name)
            unless category.companies.include?(company)
              category.companies << company
            end
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error "Failed to add company '#{normalized_name}' to category '#{category_name}': #{e.message}"
          end
        end
      end
      puts "Companies have been associated with categories based on normalized names."
    rescue StandardError => e
      Rails.logger.error "Failed to process category-company associations: #{e.message}"
      raise e  # Optionally re-raise the error if you want it to be caught by higher-level error handling, like a monitoring system.
    end
  end
end
