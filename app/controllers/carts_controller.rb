class CartsController < ApplicationController
  def show
    @cart = Cart.new(session[:cart])
    @toolbag = @cart.toolbag
    # flash messages to go here  
  end
end
