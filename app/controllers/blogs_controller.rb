class BlogsController < ApplicationController
  def index
    authorize :blog
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = authorize Blog.new
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
    authorize :blog
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
