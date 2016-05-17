require "rails_helper"

RSpec.describe "Cart" do

  before :each do
    @cart = Cart.new([])
  end

  describe "#add_home" do
    it "adds a home to the cart" do
      checkin = "05/02/2017"
      checkout = "06/05/2017"
      home = create(:home)

      @cart.add_home(home.id, checkin, checkout)
      expected_contents = [{
        "home" => home.id,
        "checkin" => checkin,
        "checkout" =>checkout
      }]
      expect(@cart.contents).to eq(expected_contents)
    end
  end

  describe "#total" do
    it "adds up the total price of all items in the cart" do
      checkin = "05/02/2017"
      checkout = "06/05/2017"
      home = create(:home)

      @cart.add_home(home.id, checkin, checkout)

      expect(@cart.total).to eq(3400.00)
    end
  end

  describe "#clear_contents" do
    it "empties the carts contents" do
      checkin = "05/02/2017"
      checkout = "06/05/2017"
      home = create(:home)

      @cart.add_home(home.id.to_s, checkin, checkout)
      @cart.clear_contents

      expect(@cart.contents).to eq(Array.new)
    end
  end

  describe "#quantity" do
    it "returns the number of items in the cart" do
      checkin = "05/02/2017"
      checkout = "06/05/2017"
      home = create(:home)

      @cart.add_home(home.id.to_s, checkin, checkout)

      expect(@cart.quantity).to eq(1)
    end
  end

  describe "#reservations" do
    it "wraps the cart contents in CartReservationObjects" do
      checkin = "05/02/2017"
      checkout = "06/05/2017"
      home = create(:home)

      @cart.add_home(home.id.to_s, checkin, checkout)
      cart_reservation = @cart.reservations.first

      expect(cart_reservation.class).to eq(CartReservation)
    end
  end
end
