require 'rails_helper'

RSpec.describe Order, type: :model do
  it {should have_many :order_tools}
  it {should belong_to :user}

  it "has status completed, cancelled, ordered, paid" do
    assert_equal Order.statuses, {"Completed" => 0, "Cancelled" => 1, "Ordered" => 2, "Paid" => 3 }
  end

  # it "must be associated with a user" do
  #   order = Order.new(total: 10.00, quantity: 5, status: "Ordered")
  #
  #   refute order.save
  # end
end
