class HomeController < ApplicationController
  def show
    ahoy.track "My first event", language: "Ruby"

    @featured_companies = Company.where(name: ['airbnb', 'basecamp', 'bloomberg'])

    @featured_blogs = Blog.featured
    # debugger
    @top_categories = Category.showcased
    @companies_by_category = {}

    @top_categories.each do |category|
      @companies_by_category[category.name] = category.companies
    end

    @top_cities = Category.top_cities
    @companies_by_city = {}

    @top_cities.each do |city|
      @companies_by_city[city.name] = city.companies
    end

    @tops_categories = Category.tops_categories
    @tops_companies = {}

    Category::TOPS_CATEGORIES_HASH.each do |category, name|
      cat = Category.find_by(name: category)
      @tops_companies[name] = cat.companies
    end
  end

    private

  def s3_service
    @s3_service ||= S3Service.new
  end
end
