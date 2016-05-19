class CartsController < ApplicationController

  def create
    reservation_request = ReservationParser.new(params)
    if reservation_request.missing_dates?
      flash[:error] = "You must have a checkin and checkout date"
    elsif reservation_request.has_checkin_after_checkout?
      flash[:error] = "You must select a checkin date before your checkout date" 
    elsif reservation_request.is_valid?
      @cart.add_home(params[:id], params[:date][:checkin_date], params[:date][:checkout_date])
      session[:cart] = @cart.contents
      flash[:success] = "You've added this reservation to your cart"
    else
      flash[:error] = "This home is already reserved on #{reservation_request.reserved_dates.join(", ")}"
    end
    session[:checkin] = nil
    session[:checkout] = nil
    redirect_to request.referrer
  end

  def destroy
    @cart.remove_home(params["home_id"], params["checkin"], params["checkout"])
    redirect_to request.referrer
  end

  def show
    @contents = @cart.reservations
  end

end
