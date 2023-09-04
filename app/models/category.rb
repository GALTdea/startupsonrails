class Category < ApplicationRecord
  has_many :categorizations
  has_many :companies, through: :categorizations
end
