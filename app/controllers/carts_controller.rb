class CartsController < ApplicationController
  def show
    if session[:cart]
      @cart = Cart.new(session[:cart])
      # @cart_homes = @cart.contents
      # @reserved_dates = session[:date].transform_values { |date_id| DateReserved.find(date_id).date_reserved.to_formatted_s(:long_ordinal)}
    else
      flash[:success] = "Start shopping before viewing your cart!"
      redirect_to root_path
    end
  end

  def update
    @cart.update_quantity(params[:cart_tool])
    flash[:success] = "Cart updated successfully."
    redirect_to cart_path
  end
end
