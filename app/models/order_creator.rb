class OrderCreator

  def initialize(cart, user)
    @cart = cart
    @user = user
    @order = create_order
    create_reservations_and_reservation_nights
  end

  def create_order
    Order.new(user: @user, total: @cart.total)
  end

  def save
    @order.save
  end

  def create_reservations_and_reservation_nights
    @cart.contents.each do |cart_reservation|
      reservation = create_reservation(cart_reservation)
      checkin_date = Date.parse(cart_reservation["checkin"])
      checkout_date = Date.parse(cart_reservation["checkout"]) - 1
      (checkin_date..checkout_date).each do |date|
        reservation.reservation_nights << ReservationNight.new(night: date)
      end
      @order.reservations << reservation
    end
  end

  private

  def create_reservation(reservation)
    reservation = Reservation.new(
      home_id: reservation["home"],
      checkin: reservation["checkin"],
      checkout: reservation["checkout"]
    )
  end
end
