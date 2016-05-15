require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:user_id) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:reservations) }
  end

  describe ".completed?" do
    it "returns true for completed order" do
      order = create(:completed_order)
      expect(order.completed?).to be(true)
    end

    it "returns false for an incomplete order" do
      order = create(:paid_order)
      expect(order.completed?).to be(false)
    end
  end

  describe ".completed!" do
    it "changes an incomplete order to completed" do
      order = create(:paid_order)
      order.completed!
      expect(order.completed?).to be(true)
    end

    it "does not change a complete order" do
      order = create(:completed_order)
      order.completed!
      expect(order.completed?).to be(true)
    end
  end

  describe ".cancelled?" do
    it "returns true for a cancelled order" do
      order = create(:cancelled_order)
      expect(order.cancelled?).to be(true)
    end

    it "returns false for an incomplete order" do
      order = create(:paid_order)
      expect(order.cancelled?).to be(false)
    end
  end

  describe ".cancelled!" do
    it "changes an non cancelled order to cancelled" do
      order = create(:order)
      order.cancelled!
      expect(order.cancelled?).to be(true)
    end

    it "does not change a cancelled order" do
      order = create(:cancelled_order)
      order.cancelled!
      expect(order.cancelled?).to be(true)
    end
  end

  describe ".ordered?" do
    it "returns true for an ordered order" do
      order = create(:order)
      expect(order.ordered?).to be(true)
    end

    it "returns false for a paid order" do
      order = create(:paid_order)
      expect(order.ordered?).to be(false)
    end
  end

  describe ".ordered!" do
    it "changes a paid order to ordered" do
      order = create(:paid_order)
      order.ordered!
      expect(order.ordered?).to be(true)
    end

    it "does not change an ordered order" do
      order = create(:order)
      order.ordered!
      expect(order.ordered?).to be(true)
    end
  end

  describe ".paid?" do
    it "returns true for a paid order" do
      order = create(:paid_order)
      expect(order.paid?).to be(true)
    end

    it "returns false for an unpaid order" do
      order = create(:order)
      expect(order.paid?).to be(false)
    end
  end

  describe ".paid!" do
    it "changes an order to paid" do
      order = create(:order)
      order.paid!
      expect(order.paid?).to be(true)
    end

    it "does not change a paid order" do
      order = create(:paid_order)
      order.paid!
      expect(order.paid?).to be(true)
    end
  end
end
