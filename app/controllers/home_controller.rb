class HomeController < ApplicationController
  def show
    @top_categories = Category.showcased
    @companies_by_category = {}
    @top_categories.each do |category|
      @companies_by_category[category.name] = category.companies
    end

    @tops_categories = Category.tops_categories
    @tops_companies = {}
    @tops_categories.each do |category|
      @tops_companies[category.name] = category.companies
    end
  end
end