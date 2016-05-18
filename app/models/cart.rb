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

  def remove_home(home_id)
    # byebug
    @contents.delete_if {|reservation| reservation["home"] == home_id}
    # @contents = @contents.each {|hash| hash.grep_v(home_id)}
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
