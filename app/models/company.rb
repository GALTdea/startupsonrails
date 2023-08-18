class Company < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  
  friendly_id :name, use: :slugged
  
  validates :name, :url, :user_id, presence: true
end
