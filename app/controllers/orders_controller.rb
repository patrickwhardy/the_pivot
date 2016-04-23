class OrdersController < ApplicationController

  def create
    @order = Order.create
    byebug
    render :index
  end

end
