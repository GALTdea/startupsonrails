# class UsersController < ApplicationController
#   def index
#   end

#   def show
#   end

#   def new
#   end

#   def create
#   end

#   def private 

#   end
# end


class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html{ redirect_to @user, notice: 'User was successfully created.' }
        format.json{ render :show, status: :created, location: @user }
      else
        format.html{ render :new }
        format.json{ render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

private
  def user_params
    params.require(:user).permit(:name, :username, :email, :password )
  end
end
