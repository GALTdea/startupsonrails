class Category < ApplicationRecord
  has_many :categorizations
  has_many :companies, through: :categorizations

  category_names = ["top_rails_companies", "trending", "hotwire", "tooling"]
  tops_categories = ["top_rails_companies", "top_contribuitors", "top_hotwire_use", "top_jr_friendly", "top_tooling", "top_indy"]

  top_cities = ["top_la", "top_ny"]

  TOPS_CATEGORIES_HASH = {
    # 'top_rails_companies' => '2023 Top Companies',
    # 'top_contribuitors' => 'Top Contribuitors',
    # 'top_hotwire_use' => 'Top Hotwire Use',
    # 'top_jr_friendly' => 'Top Jr Friendly',
    # 'top_tooling' => 'Top Tooling',
    # 'top_indy' => 'Top Indy'
    'top_la' => 'Los Angeles',
    'top_ny' => 'New York',
  }.freeze



  scope :showcased, -> { where(name: category_names) }
  scope :tops_categories, -> { where(name: tops_categories) }
  scope :top_cities, -> { where(name: top_cities ) }
end
