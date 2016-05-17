require "rails_helper"

RSpec.describe "Cart" do

  before :each do
    checkin = "05/02/2016"
    checkout = "05/06/2016"
    @home = create(:home)
    cart_item = {
      "home" => @home.id,
      "checkin" => checkin,
      "checkout" =>checkout
    }
    @cart_reservation = CartReservation.new(cart_item)
  end

  describe "#total_days" do
    it "returns the total days between check in and checkout" do
      expect(@cart_reservation.total_days).to eq(4)
    end
  end

  describe "#total" do
    it "returns the total days times the price per night" do
      expect(@cart_reservation.total).to eq(400.0)
    end
  end

  describe "#checkin" do
    it "returns a Date object of the checkin date" do
      expect(@cart_reservation.checkin).to eq(Date.parse("Mon, 02 May 2016"))
    end
  end

  describe "#checkout" do
    it "returns a Date object of the checkout date" do
      expect(@cart_reservation.checkout).to eq(Date.parse("Sat, 06 May 2016"))
    end
  end
end
