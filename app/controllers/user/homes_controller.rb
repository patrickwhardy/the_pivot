class User::HomesController < ApplicationController
  def new
    @home = Home.new
  end

  def create
    @user = current_user
    @home = @user.homes.new(home_params)
    if @home.save
      flash[:notice] = "Home successfully created."
      redirect_to user_home_path(@user, @home)
    else
      flash[:error] = @home.errors.full_messages.join(", ")
      redirect_to request.referrer
    end
  end

  def show
    @home = Home.find(params[:id])
  end

  private

  def home_params
    params.require(:home).permit(:name, :description, :price_per_night, :address)
  end
end
