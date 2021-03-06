class ReservationParser < SimpleDelegator

  attr_reader :reserved_dates
  
  def initialize(params)
    @checkin = params[:date][:checkin_date]
    @checkout = params[:date][:checkout_date]
    @home_id = params[:id]
  end

  def missing_dates?
    @checkin == "" || @checkout == ""
  end

  def has_checkin_after_checkout?
    Date.strptime(@checkin, "%m/%d/%Y") > Date.strptime(@checkout, "%m/%d/%Y")
  end

  def is_valid?
    @reserved_dates = Reservation.dates_reserved(
      @home_id, @checkin, @checkout
    )
    @reserved_dates.empty?
  end
  
end
