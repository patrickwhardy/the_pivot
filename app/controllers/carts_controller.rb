class CartsController < ApplicationController
  def show
    @cart = Cart.new(session[:cart])
    @toolbag = @cart.toolbag
  end
end
