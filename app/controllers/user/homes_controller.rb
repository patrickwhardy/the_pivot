class User::HomesController < ApplicationController
  def new
    @home = Home.new
    photo = @home.photos.build
  end

  def create
    @user = current_user
    @home = @user.homes.new(home_params)
    if @home.save
      flash[:notice] = "Home successfully created."
      redirect_to user_home_path(@user.slug, @home)
    else
      flash[:error] = @home.errors.full_messages.join(", ")
      redirect_to request.referrer
    end
  end

  def show

    @user = User.find_by(slug: params[:path])
    if @user.nil?
      redirect_to root_path
    else
      @home = @user.homes.find(params[:id])
    end
  end

  def index
    @user = User.find_by(slug: params[:path])
  end

  private

  def home_params
    params.require(:home).permit(:name, :description, :price_per_night, :address, photos_attributes: [:id, :image, :_destroy])
  end
end
