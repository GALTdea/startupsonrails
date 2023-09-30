class HomeController < ApplicationController
  def show
    @categories = Category.showcased

    @companies_by_category = {}
    @categories.each do |category|
      @companies_by_category[category.name] = category.companies
    end
  end
end
