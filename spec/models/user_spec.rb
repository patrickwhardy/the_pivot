require 'rails_helper'

RSpec.describe User, type: :model do
    it "can assign an admin" do
      admin = create(:user, role: 1)
      assert_equal "admin", admin.role
    end

    it "defaults to a user" do
      user = create(:user)
      assert_equal "user", user.role
    end

    it "requires user to have username" do
      user = User.new(password: "password")
      refute user.save
    end

    it {should have_many :orders}

    it "knows if user has orders" do
      user = create(:user)
      Order.create(user_id: user.id)

      assert_equal 1, user.orders.count
      assert user.has_orders?
    end
end
