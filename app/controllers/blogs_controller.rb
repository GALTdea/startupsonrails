class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @blogs =  Blog.all
  end

  def show
    authorize @blog
  end

  def new
    authorize @blog
  end

  def create
    @blog = authorize Blog.new(blog_params)
    @blog.user = current_user
    if @blog.save
      redirect_to @blog, notice: "Blog was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @blog
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
