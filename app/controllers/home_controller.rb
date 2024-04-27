class HomeController < ApplicationController
  def show
    ahoy.track "My first event", language: "Ruby"

    @featured_companies = Category.where(name: 'top_rails_companies').first.companies.limit(3)
    @top_categories = Category.showcased
    @companies_by_category = {}

    @top_categories.each do |category|
      @companies_by_category[category.name] = category.companies
    end

    @tops_categories = Category.tops_categories
    @tops_companies = {}

    Category::TOPS_CATEGORIES_HASH.each do |category, name|
      cat = Category.find_by(name: category)
      @tops_companies[name] = cat.companies
    end
  end
end
