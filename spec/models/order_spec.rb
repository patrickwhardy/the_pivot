require 'rails_helper'

RSpec.describe Order, type: :model do
  it {should have_many :order_tools}

  it "has status completed, cancelled, ordered, paid" do
    assert_equal Order.statuses, {"completed" => 0, "cancelled" => 1, "ordered" => 2, "paid" => 3 }
  end
end
