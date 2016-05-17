class CartsController < ApplicationController
  def create
    formatted_checkin = @cart.format_dates(params[:date][:checkin_date])
    formatted_checkout = @cart.format_dates(params[:date][:checkout_date])
    reserved_dates = Reservation.dates_reserved(
      params[:id], formatted_checkin, formatted_checkout
    )
    if reserved_dates.empty?
      @cart.add_home(params[:id], formatted_checkin, formatted_checkout)
      session[:cart] = @cart.contents
      flash[:success] = "You've added this reservation to your cart"
    else
      flash[:error] = "This home is already reserved on #{reserved_dates.join(", ")}"
    end
    redirect_to request.referrer
  end

  def show
    @contents = @cart.reservations
  end

end
