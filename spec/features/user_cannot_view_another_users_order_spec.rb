require "rails_helper"

RSpec.feature "Users have orders" do
  include SpecTestHelper
  
  scenario "and one logs in and tries to view order placed by other user" do
    user1 = create(:user)
    user2 = create(:user)
    tool1 = create(:tool, name: "tool1")
    tool2 = create(:tool, name: "tool2")
    order1 = Order.create(user_id: user1.id)
    order2 = Order.create(user_id: user1.id)
    order_tool1 = create(:order_tool, tool: tool1, quantity: 3, order: order1)
    order_tool2 = create(:order_tool, tool: tool2, quantity: 1, order: order1)
    order_tool3 = create(:order_tool, tool: tool1, quantity: 5, order: order2)
    order3 = Order.create(user_id: user2.id)
    order_tool4 = create(:order_tool, tool: tool2, quantity: 7, order: order3)

    login_user(user1)
    visit order_path(order3.id)
    assert_equal orders_path, current_path
  end

  scenario "and visitor tries to view order placed by user" do
    user1 = create(:user)
    user2 = create(:user)
    tool1 = create(:tool, name: "tool1")
    tool2 = create(:tool, name: "tool2")
    order1 = Order.create(user_id: user1.id)
    order2 = Order.create(user_id: user1.id)
    order_tool1 = create(:order_tool, tool: tool1, quantity: 3, order: order1)
    order_tool2 = create(:order_tool, tool: tool2, quantity: 1, order: order1)
    order_tool3 = create(:order_tool, tool: tool1, quantity: 5, order: order2)
    order3 = Order.create(user_id: user2.id)
    order_tool4 = create(:order_tool, tool: tool2, quantity: 7, order: order3)

    visit order_path(order3.id)
    assert_equal login_path, current_path
  end
end
