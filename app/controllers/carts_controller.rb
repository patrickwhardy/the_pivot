class CartsController < ApplicationController
  def show
    @cart = Cart.new(session[:cart])
    @toolbag = @cart.toolbag
    @cart_total = @cart.cart_total
    # @cart_subtotals = cart.subtotals # hash [tool_id => subtotal amount]
  end
end
