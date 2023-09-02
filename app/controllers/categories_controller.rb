class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    binding.pry
    if @category.save 
      redirect_to @category, notice: "Category was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  private 

  def set_category
    @category = Category.find(params[:id])
  end

end
