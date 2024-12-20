namespace :companies do
  desc 'Import companies from CSV file'
  task import: :environment do
    csv_file_path = ENV['CSV_FILE'] || Rails.root.join('db/seeds', 'ruby_rails_companies.csv')

    unless File.exist?(csv_file_path)
      puts "CSV file not found at #{csv_file_path}"
      exit
    end

    result = Company.import_from_csv(csv_file_path)

    if result[:error_messages].first == 'No admin user found. Please create an admin user first.'
      puts result[:error_messages].first
      exit
    end

    puts 'Import completed:'
    puts "Successfully imported: #{result[:success_count]} companies"
    puts "Errors encountered: #{result[:error_count]}"

    if result[:error_messages].any?
      puts "\nError details:"
      result[:error_messages].each { |msg| puts "- #{msg}" }
    end
  end

  desc 'Update companies from CSV file'
  task update: :environment do
    require 'faraday'
    require 'faraday/retry'

    csv_file_path = ENV['CSV_FILE'] || Rails.root.join('db/seeds', 'combined_companies.csv')

    unless File.exist?(csv_file_path)
      puts "CSV file not found at #{csv_file_path}"
      exit
    end

    result = Company.update_from_csv(csv_file_path)

    puts 'Update completed:'
    puts "Successfully updated: #{result[:updated_count]} companies"

    if result[:updated_companies].any?
      puts "\nUpdated companies:"
      result[:updated_companies].each { |name| puts "- #{name}" }
    end

    puts "\nCheck 'log/company_updates.log' for detailed update information."
  end
end
