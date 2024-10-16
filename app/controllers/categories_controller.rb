class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
    authorize @categories
  end

  def show
    @category = Category.find(params[:id])
    authorize @category
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    authorize @category
  end

  def update
    authorize @category
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def remove_company
    @category = Category.find(params[:id])
    @company = Company.find(params[:company_id])

    if @category.companies.delete(@company)
      flash[:notice] = 'Company removed successfully.'
    else
      flash[:alert] = 'Failed to remove company.'
    end

    redirect_to category_path(@category)
  end

  def toggle_featured
    @category = Category.find(params[:id])
    @category.update(featured: !@category.featured)
    respond_to do |format|
      format.json { render json: { featured: @category.featured } }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
