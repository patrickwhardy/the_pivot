class CartsController < ApplicationController
  def create
    reserved_dates = Reservation.dates_reserved(params[:id], params[:checkin_date], params[:checkout_date])
    if reserved_dates.empty?
      @cart.add_home(params[:id], params[:checkin_date], params[:checkout_date])
      session[:cart] = @cart.contents
      flash[:success] = "You've added this reservation to your cart"
    else
      flash[:error] = "This home is already reserved on #{reserved_dates.join(", ")}"
    end
    redirect_to request.referrer
  end

  def show
  end
end
