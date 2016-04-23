require "rails_helper"

RSpec.feature "User can view a past order" do
  scenario "user has multiple orders and clicks on a certain one" do
    # Background: An existing user that has one previous order
    #   As an authenticated user
    user1 = create(:user)
    tool1 = create(:tool, name: "tool1")
    tool2 = create(:tool, name: "tool2")
    order1 = Order.create(user_id: user1.id, closed_at: "2016-04-01 13:27:00", status: 0)
    order_tool1 = create(:order_tool, tool: tool1, quantity: 3, order: order1)
    order_tool2 = create(:order_tool, tool: tool2, quantity: 1, order: order1)
    tool1_subtotal = order_tool1.quantity * order_tool1.tool.price
    tool2_subtotal = order_tool2.quantity * order_tool2.tool.price
    total = tool1_subtotal + tool2_subtotal

    visit login_path
    fill_in "Username", with: user1.username
    fill_in "Password", with: user1.password
    # save_and_open_page
    within(".login") do
      click_on "Login"
    end
    click_on "View Past Orders"
    #   When I visit "/orders"
    #   Then I should see my past order
    #   And I should see a link to view that order
    #   And when I click that link
    click_on "Order #{order1.id}"
    # save_and_open_page
    #   Then I should see each item that was order with the quantity and line-item subtotals
    expect(page).to have_content "#{order_tool1.tool.name}, Quantity: #{order_tool1.quantity}, Subtotal: #{tool1_subtotal}"
    expect(page).to have_content "#{order_tool2.tool.name}, Quantity: #{order_tool2.quantity}, Subtotal: #{tool2_subtotal}"
    #   And I should see the current status of the order (ordered, paid, cancelled, completed)
    expect(page).to have_content "Order status: #{order1.status}"
    #   And I should see the total price for the order
    expect(page).to have_content "Order total: #{total}"
    #   And I should see the date/time that the order was submitted
    expect(page).to have_content "Submitted at: #{order1.created_at}"
    #   If the order was completed or cancelled
    #   Then I should see a timestamp when the action took place
    expect(page).to have_content "Completed at: #{order1.closed_at}"
    #   And I should see links to each item's show page
    click_on "#{order_tool2.tool.name}"
    assert_equal tools_path(order_tool2.tool.id),current_path
    expect(page).to have_content "#{tool2.name}"
    expect(page).to have_content "#{tool2.description}"

  end
end
