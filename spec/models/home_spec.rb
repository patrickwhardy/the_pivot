require "rails_helper"

RSpec.describe Home, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price_per_night) }
    it { is_expected.to validate_presence_of(:address) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:photos) }
    it { is_expected.to have_many(:reservations) }
  end

  describe ".upcoming_reservations" do
    it "returns reservations with a checkout later than today" do
      reservation = create(:upcoming_reservation)
      home = reservation.home
      home.reservations << create(:past_reservation)
      home.save
      expect(home.upcoming_reservations).to eq([reservation])
    end
  end

  describe ".past_reservations" do
    it "returns reservations with a checkout earlier than today" do
      reservation = create(:past_reservation)
      home = reservation.home
      home.reservations << create(:upcoming_reservation)
      home.save
      expect(home.past_reservations).to eq([reservation])
    end
  end

  describe ".suspended?" do
    it "should return true when asked on suspended home" do
      home = create(:suspended_home)
      expect(home.suspended?).to be(true)
    end

    it "should return false when asked on active home" do
      home = create(:home)
      expect(home.suspended?).to be(false)
    end
  end

  describe ".suspended!" do
    it "should change an active home to suspended" do
      home = create(:home)
      home.suspended!
      expect(home.suspended?).to be(true)
    end

    it "should not change an already suspended home" do
      home = create(:suspended_home)
      home.suspended!
      expect(home.suspended?).to be(true)
    end
  end

  describe ".active?" do
    it "should return true when asked on active home" do
      home = create(:home)
      expect(home.active?).to be(true)
    end

    it "should return false when asked on suspended home" do
      home = create(:suspended_home)
      expect(home.active?).to be(false)
    end
  end

  describe ".active!" do
    it "should change a suspended home to be active" do
      home = create(:suspended_home)
      home.active!
      expect(home.active?).to be(true)
    end

    it "should not change an already active home" do
      home = create(:home)
      home.active!
      expect(home.active?).to be(true)
    end
  end
end
