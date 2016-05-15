class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password]) && @user.active?
      session[:user_id] = @user.id
      flash[:success] = "Login successful. Welcome to Tiny Stay, #{@user.username.capitalize}"
      redirect_to dashboard_path(@user.slug)
    else
      flash[:error] = "Invalid email/password combination"
      redirect_to login_path
    end
  end
end
