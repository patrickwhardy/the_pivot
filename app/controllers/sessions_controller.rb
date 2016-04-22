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
    redirect_to cart_path 
  end

end
