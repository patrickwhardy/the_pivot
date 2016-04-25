class CartsController < ApplicationController
  def show
    @cart = Cart.new(session[:cart])
    @toolbag = @cart.toolbag
  end

  def update
    @cart.update_quantity(params[:cart_tool])
    flash[:success] = "Cart updated successfully."
    redirect_to cart_path
  end
end
