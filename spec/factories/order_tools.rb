FactoryGirl.define do
  factory :order_tool do
    tool
    order
    quantity 1
  end
end


# user = create(:user)
# tool1 = create(:tool, :name = "tool1")
# tool2 = create(:tool, :name = "tool2")
# order1 = Order.create(:user_id = user.id)
# order2 = Order.create(:user_id = user.id)
