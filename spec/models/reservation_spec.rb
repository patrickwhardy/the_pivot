require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:reservation_nights) }
    it { is_expected.to belong_to(:home) }
  end

  describe "self.dates_reserved" do
    it "returns an array of dates reserved between given dates" do
      reservation = create(:reservation)
      home = reservation.home
      reservation.reservation_nights.create(night: reservation.checkin)
      reservation.reservation_nights.create(night: reservation.checkout)
      date = reservation.checkin

      checkin = {"date(1i)"=>"2017", "date(2i)"=>"5", "date(3i)"=>"2"}
      checkout = {"date(1i)"=>"2017", "date(2i)"=>"5", "date(3i)"=>"5"}

      reserved = Reservation.dates_reserved(home.id, checkin, checkout)

      expect(reserved).to eq([reservation.checkin, reservation.checkout])
    end

    it "returns an empty array when no dates are reserved" do
      reservation = create(:reservation)
      home = reservation.home

      checkin = { "date(1i)"=>"2017", "date(2i)"=>"5", "date(3i)"=>"2" }
      checkout = { "date(1i)"=>"2017", "date(2i)"=>"5", "date(3i)"=>"5" }

      reserved = Reservation.dates_reserved(home.id, checkin, checkout)

      expect(reserved).to eq(Array.new)
    end
  end

  describe "self.get_reserved_dates" do
    it "returns an array of dates reserved for a home between two dates" do
      reservation = create(:reservation)
      home = reservation.home
      reservation.reservation_nights.create(night: reservation.checkin)
      reservation.reservation_nights.create(night: reservation.checkout)
      date = reservation.checkin

      checkin = Date.parse("2/5/2017")
      checkout = Date.parse("5/5/2017")

      reserved = Reservation.get_reserved_dates(home.id, checkin, checkout)

      expect(reserved).to eq([reservation.checkin, reservation.checkout])
    end
  end
end
