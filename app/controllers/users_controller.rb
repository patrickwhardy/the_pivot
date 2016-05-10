class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if current_admin?
      redirect_to admin_dashboard_path
    elsif current_user
      @user = current_user
    else
      redirect_to login_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Account created. Welcome to TinyStay, #{@user.username.capitalize}"
      if session[:cart]
        redirect_to cart_path
      else
        redirect_to dashboard_path(@user.id)
      end
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to request.referrer
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      if current_admin?
        redirect_to admin_dashboard_path
      else
        redirect_to dashboard_path
      end
    else
      flash[:error] = "An error occurred. Please try again."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name)
  end
end
