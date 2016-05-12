class OrderCreator

  def initialize(cart, user)
    @cart = cart
    @user = user
    @order = create_order
    create_reservations
    # @cart.each do |reservation|
    #   order.reservations << Reservation.create()
  end

  def create_order
    Order.new(user: @user, total: @cart.total)
  end

  def save
    @order.save
  end

  def create_reservations
    @cart.contents.each do |reservation|
      new_reservation = Reservation.new(
        home_id: reservation["home"],
        checkin: reservation["checkin"],
        checkout: reservation["checkout"]
      )
      checkin_date = Date.parse(reservation["checkin"])
      checkout_date = Date.parse(reservation["checkout"]) - 1
      (checkin_date..checkout_date).each do |date|
        new_reservation.reservation_nights << ReservationNight.new(night: date)
      end

      @order.reservations << new_reservation
    end
  end
end
