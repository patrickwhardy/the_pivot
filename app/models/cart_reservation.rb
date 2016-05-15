class CartReservation < SimpleDelegator

  attr_reader :checkin, :checkout

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
    Date.parse(
      "#{date["date(1i)"]}/#{date["date(2i)"]}/#{date["date(3i)"]}"
    )
  end
end
