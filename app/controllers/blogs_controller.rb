class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :update_status]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @blogs = Blog.all
  end

  def show
  end

  def new
    @blog = Blog.new
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

  def update
    authorize @blog
    if @blog.update(blog_params)
      redirect_to @blog, notice: "Blog was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_status
    new_status = params[:status]

    if Blog.statuses.keys.include?(new_status) && @blog.update(status: new_status)
      redirect_to @blog, notice: "Blog status was successfully updated to #{new_status}."
    else
      redirect_to @blog, alert: 'Failed to update the blog post status.'
    end
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image, :status)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
