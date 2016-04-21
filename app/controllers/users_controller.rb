class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to dashboard_path(@user.id)
    else
      #TODO make sad path test
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
