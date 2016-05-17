class CartsController < ApplicationController
  def create
    formatted_checkin = Hash.new
    checkin_array = params[:date][:checkin_date].split("/")
      3.times do |num|
        formatted_checkin["date(#{num + 1}i)"] = checkin_array[num]
      end
    formatted_checkout = Hash.new
    checkout_array = params[:date][:checkout_date].split("/")
      3.times do |num|
        formatted_checkout["date(#{num + 1}i)"] = checkout_array[num]
      end
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
