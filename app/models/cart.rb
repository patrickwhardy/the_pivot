class Cart
  attr_reader :contents

  def initialize(session_contents)
    @contents = session_contents || []
  end

  def add_home(home_id, checkin, checkout)
    @contents << {
      "home"     => home_id,
      "checkin"  => checkin,
      "checkout" => checkout
    }
  end

  def remove_home(home_id, checkin, checkout)
    @contents.delete_if do |reservation|
      reservation["home"] == home_id && reservation["checkin"] == format_date(checkin) && reservation["checkout"] == format_date(checkout)
    end
  end

  def format_date(date)
    split = date.split("-")
    split[1] + "/" + split[2] + "/" + split[0]
  end

  def total
    reservations.reduce(0) { |sum, reservation| sum + reservation.total }
  end

  def reservations
    @contents.map { |content| CartReservation.new(content) }
  end

  def clear_contents
    @contents = []
  end

  def quantity
    @contents.size
  end
end
