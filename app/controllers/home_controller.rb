class HomeController < ApplicationController
  def show
    category_names = ["cool_cats", "hotwire", "trending", "up_and_comers"]
    @categories = Category.where(name: category_names)


    @companies_by_category = {}

    @categories.each do |category|
      @companies_by_category[category.name] = category.companies
    end
    
  end
end
