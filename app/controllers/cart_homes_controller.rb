class CartHomesController < ApplicationController
  def create
      @cart.add_home(params[:id], params[:checkin_date], params[:checkout_date] )
      session[:cart] = @cart.contents
      # session[:date] = {"#{@tool.id}" => date.id}
      flash[:success] = "You've added this reservation to your cart"
      redirect_to request.referrer
  end

  def destroy
    @cart.remove(params[:id])
    flash[:alert] = "Tool removed from cart."
    redirect_to cart_path
  end
end
