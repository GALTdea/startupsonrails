# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  url        :string
#  about      :text
#  email      :string
#  location   :string
#  links      :string
#  tech_stack :text
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
require 'csv'
class Company < ApplicationRecord
  has_many :categorizations
  has_many :categories, through: :categorizations
  belongs_to :user, optional: true

  before_save :normalize_name

  has_one_attached :logo
  include ApplicationHelper

  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :with_about, -> { where.not(about:  nil).where.not(about: '') }

  validates :name, :url, :user_id, presence: true

  enum status: { pending: 0, active: 1, rejected: 2 }

  def self.import_from_csv(current_user)
    csv_file_path = Rails.root.join('db/seeds', 'companies-6.csv')

    success_count = 0
    error_count = 0
    error_messages = []

    allowed_attributes = Company.new.attributes.keys.map(&:to_sym) # Get all allowed attributes

    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row|
      row_hash = row.to_h

      # Keep only the allowed attributes
      filtered_row_hash = row_hash.slice(*allowed_attributes)

      # Add the user_id to the attributes
      filtered_row_hash[:user_id] = current_user.id

      company = self.new(filtered_row_hash)
      begin
        if company.save
          success_count += 1
        else
          error_count += 1
          error_messages << company.errors.full_messages.join(', ')
        end
      rescue ActiveRecord::RecordNotFound => e
        error_count += 1
        error_message = "Failed to save or find company named '#{filtered_row_hash[:name]}': #{e.message}"
        error_messages << error_message
        Rails.logger.error(error_message)
      end
    end

    {
      success_count: success_count,
      error_count: error_count,
      error_messages: error_messages
    }
  end

  def generated_logo_url
    "public/company_logos/#{name.downcase.gsub(' ', '_')}_logo.png"
  end
  private
  def normalize_name
    self.name = name.strip.downcase
  end

  def s3_service
    @s3_client = Aws::S3::Client.new(
      region: 'us-west-2',
      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
    )
  end

  # def self.object_key_exists?(object_key)
  #   s3_client = Aws::S3::Client.new(
  #     region: 'us-west-2',
  #     access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
  #     secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
  #   )

  #   begin
  #     s3_client.head_object(bucket: 'startupsonrails-bucket-development', key: object_key)
  #     true
  #   rescue Aws::S3::Errors::NotFound
  #     false
  #   end
  # end

end
