class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if current_user
      @user = current_user
    else
      redirect_to login_path
    end
  end

  def create
    @user = User.new(user_params)
    @user.slug = @user.username.parameterize
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Account created. Welcome to TinyStay, #{@user.username.capitalize}"
      if session[:cart]
        redirect_to cart_path
      else
        redirect_to dashboard_path(@user.slug)
      end
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to request.referrer
    end
  end

  def edit
    redirect_to root_path unless current_user
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    @user.slug = @user.username.parameterize
    if @user.save
      flash[:notice] = "Account successfully updated"
      redirect_to dashboard_path(@user.slug)
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name)
  end
end
