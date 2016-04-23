class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def cart_login
    @user = User.new
  end

  def create
     @user = User.find_by(username: params[:session][:username])
     if @user && @user.authenticate(params[:session][:password])
       session[:user_id] = @user.id
       if params[:user_action] == "checkout"
         redirect_to cart_path
       else
         redirect_to @user
       end
     else
       flash.now[:error] = 'Invalid email/password combination'
       render :new if params[:user_action] != "checkout"
       render :cart_login if params[:user_action] == "checkout"
     end
   end
end
