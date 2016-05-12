require "rails_helper"

RSpec.describe "OrderCreator" do
  it "creates a reservation and order" do
    test_user = create(:user)
    test_home = create(:home)
    test_cart = Cart.new([{
      "home"=> test_home.id,
      "checkin"=>"2017-05-02",
      "checkout"=>"2017-06-05",
      "total_days"=>34
    }])

    order_creator = OrderCreator.new(test_cart, test_user)
    order_creator.save
    order = Order.last
    reservation = Reservation.last

    expect(reservation.home_id).to eq(test_home.id)
    expect(reservation.checkin).to eq(Date.parse("2017-05-02"))
    expect(reservation.checkout).to eq(Date.parse("2017-06-05"))
    expect(ReservationNight.count).to eq(34)
    expect(order.user_id).to eq(test_user.id)
    expect(order.total).to eq(3400)
  end
end
