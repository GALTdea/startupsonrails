class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update destroy update_status]
  before_action :authenticate_user!, only: %i[new create index]

  def index
    @blogs = Blog.all
    authorize @blogs
  end

  def show
    # @blog = Blog.find(params[:id])
    @page_title = @blog.title
    @page_image_url = @blog.image.attached? ? url_for(@blog.image) : nil
  end

  def new
    @blog = Blog.new
    authorize @blog
  end

  def create
    @blog = authorize Blog.new(blog_params)
    @blog.user = current_user
    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @blog
  end

  def destroy
    authorize @blog
    @blog.destroy
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  def update
    authorize @blog
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'Blog was successfully updated.'
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
    @blog = Blog.friendly.find(params[:id])
  end
end
