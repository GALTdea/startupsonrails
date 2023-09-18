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

  extend FriendlyId
  belongs_to :user, optional: true
  
  friendly_id :name, use: :slugged
  
  validates :name, :url, :user_id, presence: true



  def self.import_from_csv(current_user)
    csv_file_path = Rails.root.join('data', 'companies.csv')

    success_count = 0
    error_count = 0
    error_messages = []

    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row|
      row_hash = row.to_h
      row_hash[:user_id] = current_user.id  # Add the user_id to the attributes

      company = self.new(row_hash)

      if company.save
        success_count += 1
      else
        error_count += 1
        error_messages << company.errors.full_messages.join(', ')
      end
    end

    {
      success_count: success_count,
      error_count: error_count,
      error_messages: error_messages
    }
  end
end
