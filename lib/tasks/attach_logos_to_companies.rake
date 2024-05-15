namespace :logos do
  desc "Attach logos to company records"
  task attach: :environment do
    # Path to the directory containing logos
    logo_directory = Rails.root.join('company_logos')

    # Iterate over each company and attach the corresponding logo
    Company.find_each do |company|
      logo_path = logo_directory.join("#{company.name.downcase.gsub(/\s+/, '_')}_logo.png")
      if File.exist?(logo_path)
        # Attach the logo using Active Storage
        company.logo.attach(io: File.open(logo_path), filename: "#{company.name.downcase.gsub(/\s+/, '_')}_logo.png", content_type: 'image/png')

        puts "Attached logo for #{company.name}"
      else
        puts "Logo not found for #{company.name}"
      end
    end
  end
end
