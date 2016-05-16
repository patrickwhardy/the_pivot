require "rails_helper"

RSpec.describe "Cart" do

  before :each do
    checkin = {"date(1i)"=>"2017", "date(2i)"=>"5", "date(3i)"=>"2"}
    checkout = {"date(1i)"=>"2017", "date(2i)"=>"6", "date(3i)"=>"5"}
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
      expect(@cart_reservation.total_days).to eq(34)
    end
  end

  describe "#total" do
    it "returns the total days times the price per night" do
      expect(@cart_reservation.total).to eq(3400.0)
    end
  end

  describe "#checkin" do
    it "returns a Date object of the checkin date" do
      expect(@cart_reservation.checkin).to eq(Date.parse("Tue, 02 May 2017"))
    end
  end

  describe "#checkout" do
    it "returns a Date object of the checkout date" do
      expect(@cart_reservation.checkin).to eq(Date.parse("Tue, 02 May 2017"))
    end
  end
end
