# namespace :data_update do
#   desc "Associate companies with categories based on normalized names"
#   task associate_companies: :environment do
#     begin
#       Category::CATEGORY_COMPANY_MAP.each do |category_name, company_names|
#         category = Category.find_by(name: category_name.downcase.strip)
#         company_names.each do |company_name|
#           normalized_name = company_name.downcase.strip

#           begin
#             company = Company.find_by(name: normalized_name)
#             # debugger
#             unless category.companies.include?(company)
#               category.companies << company
#             end
#           rescue ActiveRecord::RecordInvalid => e
#             Rails.logger.error "Failed to add company '#{normalized_name}' to category '#{category_name}': #{e.message}"
#           end
#         end
#       end
#       puts "Companies have been associated with categories based on normalized names."
#     rescue StandardError => e
#       Rails.logger.error "Failed to process category-company associations: #{e.message}"
#       raise e  # Optionally re-raise the error if you want it to be caught by higher-level error handling, like a monitoring system.
#     end
#   end
# end


# to run the task, run the following command:
# bundle exec rake data_update:associate_companies
namespace :data_update do
  desc "Associate companies with categories based on normalized names"
  task associate_companies: :environment do
    Category::CATEGORY_COMPANY_MAP.each do |category_name, company_names|
      category = Category.find_by(name: category_name.downcase.strip)
      company_names.each do |company_name|
        normalized_name = company_name.downcase.strip
        company = Company.find_by(name: normalized_name) || Company.create(name: normalized_name)

        if company.persisted?
          unless category.companies.include?(company)
            category.companies << company
          end
        else
          Rails.logger.error "Failed to create/find company with name '#{normalized_name}': #{company.errors.full_messages.join(", ")}"
        end
      end
    end
    puts "Companies have been associated with categories based on normalized names."
  end
end
