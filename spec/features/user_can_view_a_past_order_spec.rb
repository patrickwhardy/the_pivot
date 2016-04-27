require "rails_helper"

RSpec.feature "User can view a past order" do
  include SpecTestHelper

  scenario "user has multiple orders and clicks on a certain one" do

    user1 = create(:user)
    tool1 = create(:tool, name: "tool1")
    tool2 = create(:tool, name: "tool2", price: 10)
    order1 = Order.create(user_id: user1.id, closed_at: "2016-04-01 13:27:00", status: 0)
    order_tool1 = create(:order_tool, tool: tool1, quantity: 3, order: order1)
    order_tool2 = create(:order_tool, tool: tool2, quantity: 1, order: order1)
    tool1_subtotal = order_tool1.quantity * order_tool1.tool.price
    tool2_subtotal = order_tool2.quantity * order_tool2.tool.price
    total = tool1_subtotal + tool2_subtotal
    login_user(user1)

    click_on "View Past Orders"
    click_on "Order ##{order1.id}"

    expect(page).to have_content "#{order_tool1.tool.name}"
    expect(page).to have_content "#{order_tool1.quantity}"
    expect(page).to have_content "$#{tool1_subtotal}"
    expect(page).to have_content "#{order_tool2.tool.name}"
    expect(page).to have_content "#{order_tool2.quantity}"
    expect(page).to have_content "$#{tool2_subtotal}"
    expect(page).to have_content "#{order1.status}"
    expect(page).to have_content "#{total}"
    expect(page).to have_content "#{order1.created_at.strftime('%A, %b %d, %Y')}"
    expect(page).to have_content "#{order1.closed_at}"

    click_on "#{order_tool2.tool.name}"

    assert_equal tools_path(order_tool2.tool.id),current_path
    expect(page).to have_content "#{tool2.name}"
    expect(page).to have_content "#{tool2.description}"
  end

  scenario "unless there are no past orders" do
    user = create(:user)
    login_user(user)

    assert_equal 0, user.orders.count
    expect(page).to have_no_content "View Past Orders"

    visit "/orders/1"
    assert_equal root_path, current_path
    expect(page).to have_content "Not a valid request."
  end


end
