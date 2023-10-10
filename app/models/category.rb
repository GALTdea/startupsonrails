class Category < ApplicationRecord
  has_many :categorizations
  has_many :companies, through: :categorizations

  category_names = ["top_rails_companies", "cool_cats", "hotwire", "trending", "up_and_comers"]
  scope :showcased, -> { where(name: category_names) }
end
