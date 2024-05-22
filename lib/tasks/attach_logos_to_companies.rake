require 'open-uri'
require 'net/http'

namespace :logos do
  desc "Attach logos to companies"
  task attach: :environment do
    Company.find_each do |company|
      begin
        # Skip if logo is already attached
        if company.logo.attached?
          puts "Logo already attached for #{company.name}, skipping."
          next
        end

        # Generate logo URL using the new method
        logo_url = company.generated_logo_url
        puts "Attempting to fetch logo from URL: #{logo_url}"

        begin
          # Attempt to open the URL
          if File.exist?(logo_url)
            company.logo.attach(io: File.open(logo_url), filename: "#{company.name.downcase.gsub(' ', '_')}_logo.png", content_type: 'image/png')
            company.save!
            puts "Attached logo for #{company.name} from local file"
          else
            puts "No local logo file found for #{company.name}, skipping."
          end
        rescue StandardError => e
          puts "Error attaching logo for #{company.name}: #{e.message}"
        end
      rescue StandardError => e
        puts "Error processing #{company.name}: #{e.message}"
      end
    end
  end
end
