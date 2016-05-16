require "rails_helper"

RSpec.describe "OrderCreator" do

  before :each do
    @user = create(:user)
    @home = create(:home)
    @cart = Cart.new([{
      "home"=> @home.id,
      "checkin"=>{"date(1i)"=>"2017", "date(2i)"=>"5", "date(3i)"=>"2"},
      "checkout"=>{"date(1i)"=>"2017", "date(2i)"=>"6", "date(3i)"=>"5"},
      "total_days"=>34
    }])
  end

  it "creates a reservation and order" do
    order_creator = OrderCreator.new(@cart, @user)
    order_creator.save
    order = Order.last
    reservation = Reservation.last

    expect(reservation.home_id).to eq(@home.id)
    expect(reservation.checkin).to eq(Date.parse("2017-05-02"))
    expect(reservation.checkout).to eq(Date.parse("2017-06-05"))
    expect(ReservationNight.count).to eq(34)
    expect(order.user_id).to eq(@user.id)
    expect(order.total).to eq(3400)
  end

  describe "#create_order" do
    it "creates a new order object after OrderCreator initializes" do
      order_creator = OrderCreator.new(@cart, @user)

      order = order_creator.create_order

      expect(order.class).to eq(Order)
    end

    it "does not save the order into the database" do
      order_creator = OrderCreator.new(@cart, @user)

      order = order_creator.create_order

      expect(Order.count).to eq(0)
    end
  end

  describe "#save" do
    it "saves the new order object to the database" do
      order_creator = OrderCreator.new(@cart, @user)

      order_creator.save

      expect(Order.count).to eq(1)
    end
  end

  describe "#create_reservations_and_reservation_nights" do
    it "creates reservations for each home in the order" do
      order_creator = OrderCreator.new(@cart, @user)
      order_creator.create_reservations_and_reservation_nights
      order_creator.save
      expect(Reservation.count).to eq(2)
    end

    it "attaches those reservations to the order" do
      order_creator = OrderCreator.new(@cart, @user)
      order_creator.create_reservations_and_reservation_nights
      order_creator.save
      reservations = Order.last.reservations
      expect(reservations.count).to eq(2)
    end

    it "creates a reservation night for each night in each reservation" do
      order_creator = OrderCreator.new(@cart, @user)
      order_creator.create_reservations_and_reservation_nights
      order_creator.save
      expect(ReservationNight.count).to eq(68)
    end
  end
end
