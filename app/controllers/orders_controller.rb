class OrdersController < ApplicationController

  def create
    @order = Order.create
    session[:cart].each do |tool_id, quantity|
      OrderTool.create(tool_id: tool_id, quantity: quantity, order_id: @order.id)
    end
    render :index
  end

end
