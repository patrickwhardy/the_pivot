require "rails_helper"

RSpec.feature "User can view past orders" do
  scenario "user has multiple past orders" do
    # Background: An existing user that has multiple orders
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

    #   As an Authenticated User
    visit login_path
    fill_in "Username", with: user1.username
    fill_in "Password", with: user1.password
    # save_and_open_page
    within(".login") do
      click_on "Login"
    end

    assert_equal dashboard_path(user1.id), current_path
    # save_and_open_page
    click_on "View Past Orders"
    #   When I visit "/orders"
    #   Then I should see all orders belonging to me and no other orders
    assert_equal "/orders", current_path
    expect(page).to have_content "Order ##{order1.id}"
    expect(page).to have_content "Order ##{order2.id}"
    assert_equal 3, Order.count
    expect(page).to have_no_content "Order ##{order3.id}"
  end
end
