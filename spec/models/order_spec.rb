require 'rails_helper'

RSpec.describe Order, type: :model do
  it {should have_many :order_tools}

  it "has status completed, cancelled, ordered, paid" do
    assert_equal Order.statuses, {"Completed" => 0, "Cancelled" => 1, "Ordered" => 2, "Paid" => 3 }
  end
end
