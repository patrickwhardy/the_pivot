class OrdersController < ApplicationController

  def create
    @order_creator = OrderCreator.new(session)
    if @order_creator.save
      flash[:success] = "Order was successfully placed."
      @cart.clear_contents
      session[:cart] = @cart.contents
      redirect_to orders_path
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to cart_path
    end
  end

  def index
    @orders = current_user.orders
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
