class ApplicationController < ActionController::Base
  helper ApplicationHelper
  protect_from_forgery with: :exception

  before_action :set_cart
  helper_method :current_user

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    if session[:user_id].present?
      @current_user ||= User.find(session[:user_id])
    end
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
