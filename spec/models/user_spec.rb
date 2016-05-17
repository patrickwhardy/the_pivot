require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end

  describe "associations" do
    it { is_expected.to have_many(:homes) }
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:reservations) }
    it { is_expected.to have_many(:user_roles) }
    it { is_expected.to have_many(:roles) }
  end

  describe "#admin?" do
    it "returns true for an admin user" do
      admin = create(:admin)
      expect(admin.admin?).to be(true)
    end

    it "returns false for non admin user" do
      user = create(:user)
      expect(user.admin?).to be(false)
    end
  end

  describe "#retire" do
    it "changes the user's status to deleted" do
      user = create(:user)
      user.retire
      expect(user.deleted?).to be(true)
    end

    it "suspends the users homes" do
      user = create(:home).user
      user.retire
      expect(Home.last.suspended?).to be(true)
    end
  end

  describe "#upcoming_reservations" do
    it "returns reservations with a checkout later than today" do
      order = create(:order)
      reservation = create(:upcoming_reservation)
      order.reservations << reservation
      order.reservations << create(:past_reservation)
      user = order.user
      user.save
      expect(user.upcoming_reservations).to eq([reservation])
    end
  end

  describe "#past_reservations" do
    it "returns reservations with a checkout earlier than today" do
      order = create(:order)
      reservation = create(:past_reservation)
      order.reservations << reservation
      order.reservations << create(:upcoming_reservation)
      user = order.user
      user.save
      expect(user.past_reservations).to eq([reservation])
    end
  end

  describe "#home_owner?" do
    it "returns true if a user owns homes" do
      user = create(:home).user
      expect(user.home_owner?).to be(true)
    end

    it "returns false if a user does not have any homes" do
      user = create(:user)
      expect(user.home_owner?).to be(false)
    end
  end

  describe ".home_owners" do
    it "returns an array of all users who have homes" do
      expect(User.count).to eq(1)
      horrible = User.first
      User.delete(horrible.id)
      expect(User.count).to eq(0)
      user = create(:user)
      home_owner = create(:home).user

      expect(User.home_owners).to eq([home_owner])
    end
  end

  describe "#active?" do
    it "returns true for an active user" do
      user = create(:user)
      expect(user.active?).to be(true)
    end

    it "returns false for a deleted user" do
      user = create(:deleted_user)
      expect(user.active?).to be(false)
    end
  end

  describe "#active!" do
    it "changes a deleted user to active" do
      user = create(:deleted_user)
      user.active!
      expect(user.active?).to be(true)
    end

    it "does not change an active user" do
      user = create(:user)
      user.active!
      expect(user.active?).to be(true)
    end
  end

  describe "#deleted?" do
    it "returns true for a deleted user" do
      user = create(:deleted_user)
      expect(user.deleted?).to be(true)
    end

    it "returns false for an active user" do
      user = create(:user)
      expect(user.deleted?).to be(false)
    end
  end

  describe "#deleted!" do
    it "changes an active user to deleted" do
      user = create(:user)
      user.deleted!
      expect(user.deleted?).to be(true)
    end

    it "does not change a deleted user" do
      user = create(:deleted_user)
      user.deleted!
      expect(user.deleted?).to be(true)
    end
  end
end
