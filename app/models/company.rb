class Company < ApplicationRecord
  belongs_to :user

  validates :name, :url, :user_id, presence: true
  
end
