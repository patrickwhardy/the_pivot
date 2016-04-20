class CartsController < ApplicationController
  def show
    cart = Cart.new(session[:cart])
    @toolbag = cart.toolbag
    @cart_total = cart.cart_total
  end
end
