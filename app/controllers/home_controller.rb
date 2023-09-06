class HomeController < ApplicationController
  def show
    test_category = Category.first
    @test_list = test_category.companies

    cool_cats = Category.find(2)
    @cool_cats = cool_cats.companies

    hotwire = Category.find(3)
    @hotwire = hotwire.companies
    
  end
end
