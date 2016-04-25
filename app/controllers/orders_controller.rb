class OrdersController < ApplicationController
  before_action :check_user, only: [:show]

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

  def create
    @order = Order.create(user_id: current_user.id, total: @cart.total, quantity: @cart.quantity, status: "Ordered")
    session[:cart].each do |tool_id, quantity|
      OrderTool.create(tool_id: tool_id, quantity: quantity, order_id: @order.id)
    end
    flash[:success] = "Order was successfully placed."
    @cart.clear_contents
    session[:cart] = @cart.contents
    redirect_to orders_path
  end

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

end
