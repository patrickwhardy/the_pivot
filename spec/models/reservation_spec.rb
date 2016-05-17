require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:reservation_nights) }
    it { is_expected.to belong_to(:home) }
  end

  describe ".dates_reserved" do
    it "returns an array of dates reserved between given dates" do
      reservation = create(:reservation)
      home = reservation.home
      reservation.reservation_nights.create(night: reservation.checkin)
      reservation.reservation_nights.create(night: reservation.checkout)
      date = reservation.checkin

      checkin = "02/05/2017"
      checkout = "05/05/2017"

      reserved = Reservation.dates_reserved(home.id, checkin, checkout)

      expect(reserved).to eq([reservation.checkin, reservation.checkout])
    end

    it "returns an empty array when no dates are reserved" do
      reservation = create(:reservation)
      home = reservation.home

      checkin = "02/05/2017"
      checkout = "05/05/2017"

      reserved = Reservation.dates_reserved(home.id, checkin, checkout)

      expect(reserved).to eq(Array.new)
    end
  end

  describe ".get_reserved_dates" do
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
