
class OrdersController < ApplicationController
  before_action :check_user, only: [:show]

  def create
    @order_creator = OrderCreator.new(@cart, current_user)
    if @order_creator.save
      flash[:success] = "Order was successfully placed."
      @cart.clear_contents
      session[:cart] = @cart.contents
      redirect_to dashboard_path(current_user.slug)
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to cart_path
    end
  end

  private

  def check_user
    if Order.exists?(params[:id])
      if current_user
        redirect_to orders_path unless current_user.orders.include?(Order.find(params[:id]))
      else
        redirect_to login_path
      end
    else
      flash[:danger] = "Not a valid request."
      redirect_to root_path
    end
  end
end
