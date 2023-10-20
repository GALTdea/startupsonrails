class HomeController < ApplicationController
  def show
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
