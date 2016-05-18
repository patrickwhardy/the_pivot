class User::HomesController < ApplicationController
  def new
    @home = Home.new
    photo = @home.photos.build
  end

  def index
    @user = User.find_by(slug: params[:path])
  end

  def edit
    @user = User.find_by(slug: params[:path])
    redirect_to root_path unless @user == current_user || current_admin?
    if @user
      @home = @user.homes.find_by(id: params[:id])
      redirect_to root_path if @home.nil?
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(id: params[:path])
    redirect_to root_path unless @user == current_user || current_admin?
    @home = @user.homes.find_by(id: params[:id])
    if @home.nil?
      redirect_to root_path
    else
      @home.update(home_params)
      if @home.save
        flash[:notice] = "Home successfully updated"
        redirect_to user_home_path(@user.slug, @home)
      else
        flash[:error] = @home.errors.full_messages.join(", ")
        render :edit
      end
    end
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

  def destroy
    home = current_user.homes.find(params[:id])
    home.suspended!
    flash[:warning] = "#{home.name} has been suspended"
    redirect_to admin_homes_path
  end

  private

  def home_params
    params.require(:home).permit(:name, :description, :price_per_night, :address, photos_attributes: [:id, :image, :_destroy])
  end
end
