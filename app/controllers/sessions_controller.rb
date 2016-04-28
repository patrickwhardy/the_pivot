class SessionsController < ApplicationController
  def new
    @user = User.new
    @checkout = true if env["PATH_INFO"] == "/cart/login"
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if @user.admin?
        flash[:success] = "Admin Login successful."
        redirect_to admin_dashboard_path
      elsif params[:user_action] == "checkout"
        flash[:success] = "Login successful. Please continue checking out."
        redirect_to cart_path
      else
        flash[:success] = "Login successful. Welcome to ToolChest, #{@user.username.capitalize}"
        if env["PATH_INFO"] == "/cart/login"
          redirect_to cart_path
        else
          redirect_to dashboard_path(@user.id)
        end
      end
    else
      if params[:user_action] == "checkout"
        flash[:error] = "Unable to login. Please check your username
                        and password or create an account."
        redirect_to cart_login_path
      else
        flash.now[:error] = "Invalid email/password combination"
        render :new
      end
    end
  end
end
