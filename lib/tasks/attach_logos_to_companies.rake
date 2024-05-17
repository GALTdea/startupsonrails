# namespace :logos do
#   desc "Attach logos to company records"
#   task attach: :environment do
#     # Path to the directory containing logos
#     logo_directory = Rails.root.join('company_logos')

#     # Iterate over each company and attach the corresponding logo
#     Company.find_each do |company|
#       logo_path = logo_directory.join("#{company.name.downcase.gsub(/\s+/, '_')}_logo.png")
#       if File.exist?(logo_path)
#         # Attach the logo using Active Storage
#         company.logo.attach(io: File.open(logo_path), filename: "#{company.name.downcase.gsub(/\s+/, '_')}_logo.png", content_type: 'image/png')

#         puts "Attached logo for #{company.name}"
#       else
#         puts "Logo not found for #{company.name}"
#       end
#     end
#   end
# end

# namespace :logos do
#   desc "Attach logos to company records"
#   task attach: :environment do
#     require 'aws-sdk-s3'
#     require 'open-uri'

#     # Determine the bucket based on the environment
#     bucket_name = if Rails.env.production?
#                     "startupsonrails-bucket"
#                   else
#                     "startupsonrails-bucket-development"
#                   end

#     # Initialize the S3 client
#     s3 = Aws::S3::Client.new(
#       region: "us-west-2",
#       access_key_id: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :access_key_id),
#       secret_access_key: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :secret_access_key)
#     )

#     # Iterate over each company and download the corresponding logo from S3
#     Company.find_each do |company|
#       s3_key = "company_logos/#{company.name.downcase.gsub(/\s+/, '_')}_logo.png"
#       begin
#         # Generate a pre-signed URL for the S3 object
#         signer = Aws::S3::Presigner.new(client: s3)
#         debugger
#         logo_url = signer.presigned_url(:get_object, bucket: bucket_name, key: s3_key)

#         # Attach the logo using Active Storage
#         file = URI.open(logo_url)
#         company.logo.attach(io: file, filename: "#{company.name.downcase.gsub(/\s+/, '_')}_logo.png", content_type: 'image/png')

#         puts "Attached logo for #{company.name}"
#       rescue Aws::S3::Errors::NoSuchKey
#         puts "Logo not found for #{company.name}"
#       end
#     end
#   end
# end


# require 'open-uri'
# require 'net/http'

# namespace :logos do
#   desc "Attach logos to companies"
#   task attach: :environment do
#     Company.find_each do |company|
#       begin
#         # Skip if logo is already attached
#         if company.logo.attached?
#           puts "Logo already attached for #{company.name}, skipping."
#           next
#         end
#         debugger
#         logo_url = company.logo_url
#         puts "Attempting to fetch logo from URL: #{logo_url}"

#         begin
#           # Attempt to open the URL
#           response = URI.open(logo_url)

#           if response.status[0] == "200"
#             company.logo.attach(io: StringIO.new(response.read), filename: "logo_#{company.id}.png", content_type: 'image/png')
#             company.save!
#             puts "Attached logo for #{company.name}"
#           else
#             puts "Failed to fetch logo for #{company.name}: #{response.status.join(' ')}"
#           end
#         rescue OpenURI::HTTPError => e
#           if e.message.include?("404 Not Found")
#             puts "Logo not found for #{company.name}, skipping."
#           else
#             puts "HTTPError for #{company.name}: #{e.message}"
#           end
#         end
#       rescue StandardError => e
#         puts "Error attaching logo for #{company.name}: #{e.message}"
#       end
#     end
#   end
# end


# require 'open-uri'
# require 'aws-sdk-s3'

# namespace :logos do
#   desc "Attach logos to companies"
#   task attach: :environment do
#     # Set up AWS S3 client
#     s3 = Aws::S3::Client.new(
#       region: 'us-west-2',
#       access_key_id: Rails.application.credentials.dig(:aws, :development, :access_key_id),
#       secret_access_key: Rails.application.credentials.dig(:aws, :development, :secret_access_key),
#     )
#     bucket_name = 'startupsonrails-bucket-development'

#     Company.find_each do |company|
#       begin
#         # Check if logo is already attached
#         if company.logo.attached?
#           puts "Logo already attached for #{company.name}, skipping."
#           next
#         end

#         # Generate S3 key for the logo
#         s3_key = "company_logos/#{company.name.downcase.gsub(/\s+/, '_')}_logo.png"
#         debugger
#         puts "Attempting to fetch logo from S3 key: #{s3_key}"

#         begin
#           # Generate a pre-signed URL for the S3 object
#           signer = Aws::S3::Presigner.new(client: s3)
#           logo_url = signer.presigned_url(:get_object, bucket: bucket_name, key: s3_key)

#           # Attach the logo using Active Storage
#           file = URI.open(logo_url)
#           company.logo.attach(io: file, filename: "#{company.name.downcase.gsub(/\s+/, '_')}_logo.png", content_type: 'image/png')
#           company.save!
#           puts "Attached logo for #{company.name}"

#         rescue Aws::S3::Errors::NoSuchKey
#           puts "Logo not found for #{company.name}, skipping."
#         end
#       rescue OpenURI::HTTPError => e
#         puts "HTTPError for #{company.name}: #{e.message}"
#       rescue StandardError => e
#         puts "Error attaching logo for #{company.name}: #{e.message}"
#       end
#     end
#   end
# end
