class BlogsController < ApplicationController
  def index
    authorize :blog
  end

  def show
  end

  def new
    authorize :blog
  end

  def edit
    authorize :blog
  end
end
