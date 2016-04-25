class OrdersController < ApplicationController

  def create
    @order = Order.create(user_id: session[:user_id], total: @cart.total, quantity: @cart.quantity, status: "Ordered")
    session[:cart].each do |tool_id, quantity|
      OrderTool.create(tool_id: tool_id, quantity: quantity, order_id: @order.id)
    end
    flash[:success] = "Order was successfully placed."
    @cart.clear_contents
    session[:cart] = @cart.contents
    redirect_to orders_path
  end

  def index
    @orders = Order.where(user_id: session[:user_id])
  end

  def show
    if Order.exists?(params[:id])
      @order = Order.find(params[:id])
    else
      flash[:danger] = "Not a valid request."
      redirect_to root_path
    end
  end

end
