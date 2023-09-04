class HomeController < ApplicationController
  def show
    @test_category = Category.first
    @test_list = @test_category.companies
    
  end
end
