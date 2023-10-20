class Category < ApplicationRecord
  has_many :categorizations
  has_many :companies, through: :categorizations

  category_names = ["top_rails_companies", "trending", "hotwire", "tooling"]
  scope :showcased, -> { where(name: category_names) }

  tops_categories = ["top_bootstraped", "top_contribuitors", "top_rails_companies", "top_hotwire_use", "top_jr_friendly", "top_tooling", "top_indy"]
  scope :tops_categories, -> { where(name: tops_categories) }
end
