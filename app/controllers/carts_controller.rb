class CartsController < ApplicationController
  def show
    @cart = Cart.new(session[:cart])
    @toolbag = @cart.toolbag
    @cart_total = @cart.cart_total
    # flash messages to go here
  end
end
