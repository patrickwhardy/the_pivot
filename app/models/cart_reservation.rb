class CartReservation < SimpleDelegator

  attr_reader :checkin, :checkout, :home

  def initialize(reservation)
    @home = Home.find(reservation["home"])
    @checkin = parse_date(reservation["checkin"])
    @checkout = parse_date(reservation["checkout"])
    super(@home)
  end

  def total_days
    (checkout - checkin).to_i
  end

  def total
    total_days * price_per_night
  end

  private

  def parse_date(date)
    Date.strptime(date, "%m/%d/%Y")
  end
end
