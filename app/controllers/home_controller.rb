class HomeController < ApplicationController
  def show
    ahoy.track 'My first event', language: 'Ruby'
    # @featured_categories = Category.featured_with_companies
    @featured_categories = Category.where(featured: true).limit(6)
    @featured_blogs = Blog.featured

    @top_categories = Category.showcased
    @companies_by_category = {}

    @top_categories.each do |category|
      @companies_by_category[category.name] = category.companies
    end

    @top_cities = Category.top_cities
    @companies_by_city = {}

    @featured_blogs = Blog.featured

    @top_cities.each do |city|
      @companies_by_city[city.name] = city.companies
    end

    @tops_categories = Category.tops_categories
    @tops_companies = {}

    Category::TOPS_CATEGORIES_HASH.each do |category, name|
      cat = Category.find_by(name: category)
      @tops_companies[name] = cat.companies
    end

    # @issues = Issue.includes(:company).order(created_at: :desc).limit(10)
    @issues = Issue.order(created_at: :desc).limit(10)
  end

  def index
    @featured_categories = Category.where(featured: true).limit(5)
  end
end
