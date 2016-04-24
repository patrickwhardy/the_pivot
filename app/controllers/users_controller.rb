class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to login_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Account created. Welcome to ToolChest, #{@user.username.capitalize}"
      redirect_to dashboard_path(@user.id)
    else
      flash[:error] = "Username and password are required to create an account."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
