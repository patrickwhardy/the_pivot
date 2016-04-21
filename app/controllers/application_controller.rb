class ApplicationController < ActionController::Base
  helper ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # initialize a cart
  before_action :set_cart
  helper_method :current_user

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    if session[:user_id].nil?
      @current_user = nil
    else
      @current_user = User.find(session[:user_id])
    end

  end
end
