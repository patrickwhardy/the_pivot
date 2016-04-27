require "rails_helper"

RSpec.feature "User can checkout" do
  include SpecTestHelper
  scenario "user clicks on 'checkout' in the cart and checks out" do
    user = create(:user)
    add_tools_to_cart(5)
    
    click_on "Item"
    click_on "Login or Create Account to Checkout"
    within(".login") do
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Login"
    end

    assert_equal cart_path, current_path
    expect(page).to have_content "Tool0"
    expect(page).to have_content "Tool1"
    expect(page).to have_content "Tool2"
    expect(page).to have_content "Tool3"
    expect(page).to have_content "Tool4"
    click_on "Checkout Now"

    assert_equal orders_path, current_path
    expect(page).to have_content "Order was successfully placed"

    assert_equal 1, Order.count
    order = Order.last
    assert_equal "Tool4", OrderTool.find_by(order_id: order.id).tool.name
    expect(page).to have_content "Order ##{order.id}"
  end
end
