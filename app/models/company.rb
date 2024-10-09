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
  belongs_to :user
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :contributions
  has_many :issues, dependent: :destroy

  before_save :normalize_name

  has_one_attached :logo
  include ApplicationHelper

  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :with_about, -> { where.not(about: nil).where.not(about: '') }

  validates :name, :url, presence: true, uniqueness: true

  enum status: { pending: 0, active: 1, rejected: 2 }

  scope :duplicates, -> { select(:name, :url).group(:name, :url).having('count(*) > 1').pluck(:name, :url) }

  def self.import_from_csv(csv_file_path = nil)
    # csv_file_path ||= Rails.root.join('db/seeds', 'ruby_rails_companies.csv')
    csv_file_path ||= Rails.root.join('db/seeds', 'combined_companies.csv')
    success_count = 0
    error_count = 0
    error_messages = []

    allowed_attributes = Company.new.attributes.keys.map(&:to_sym)

    # Find the first admin user
    admin_user = User.find_by(user_type: :admin)

    unless admin_user
      return {
        success_count: 0,
        error_count: 0,
        error_messages: ['No admin user found. Please create an admin user first.']
      }
    end

    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row|
      row_hash = row.to_h
      filtered_row_hash = row_hash.slice(*allowed_attributes)
      filtered_row_hash[:user_id] = admin_user.id

      company = new(filtered_row_hash)
      begin
        if company.save
          success_count += 1
        else
          error_count += 1
          error_messages << "Failed to save company '#{filtered_row_hash[:name]}': #{company.errors.full_messages.join(', ')}"
        end
      rescue ActiveRecord::RecordNotUnique => e
        error_count += 1
        error_messages << "Duplicate company '#{filtered_row_hash[:name]}': #{e.message}"
      rescue StandardError => e
        error_count += 1
        error_messages << "Error processing company '#{filtered_row_hash[:name]}': #{e.message}"
      end
    end

    {
      success_count:,
      error_count:,
      error_messages:
    }
  end

  def generated_logo_url
    "public/company_logos/#{name.downcase.gsub(' ', '_')}_logo.png"
  end

  private

  def normalize_name
    self.name = name.strip.downcase
  end

  scope :search_by_location, ->(location) { where('location ILIKE ?', "%#{location}%") }

  has_many :open_source_projects, dependent: :destroy
  # has_many :users
  has_many :open_source_projects

  def self.export_to_csv
    require 'csv'

    CSV.generate(headers: true) do |csv|
      csv << column_names

      find_each do |company|
        csv << company.attributes.values
      end
    end
  end
end
