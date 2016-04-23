class OrdersController < ApplicationController

  def create
    @order = Order.create
    session[:cart].each do |tool_id, quantity|
      OrderTool.create(tool_id: tool_id, quantity: quantity, order_id: @order.id)
    end
    flash[:success] = "Order was successfully placed."
    render :show
  end

  def index
    @orders = Order.where(user_id: session[:user_id])
  end

end
