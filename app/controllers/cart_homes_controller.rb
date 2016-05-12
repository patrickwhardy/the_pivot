class CartHomesController < ApplicationController
  def create
    reserved_dates = @cart.add_home(params[:id], params[:checkin_date], params[:checkout_date])
    if reserved_dates == []
      session[:cart] = @cart.contents
      flash[:success] = "You've added this reservation to your cart"
    else
      flash[:error] = "This home is already reserved on #{reserved_dates.join(", ")}"
    end
    redirect_to request.referrer
  end

  def destroy
    @cart.remove(params[:id])
    flash[:alert] = "Tool removed from cart."
    redirect_to cart_path
  end
end
