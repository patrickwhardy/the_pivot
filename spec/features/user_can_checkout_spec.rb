require "rails_helper"

RSpec.feature "User can checkout" do
  include SpecTestHelper
  scenario "user clicks on 'checkout' in the cart and checks out" do
    user = create(:user)
    # As a visitor
    # When I add items to my cart
    add_tools_to_cart(5)
    # And I visit "/cart"
    click_on "View Cart"
    # And I click "Checkout"
    click_on "Login or Create Account to Checkout"
    # save_and_open_page
    # Then I should be required to login
    within(".login") do
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Login"
    end

    # When I am logged in I should be taken back to my cart
    assert_equal cart_path, current_path
    expect(page).to have_content "Tool0"
    expect(page).to have_content "Tool1"
    expect(page).to have_content "Tool2"
    expect(page).to have_content "Tool3"
    expect(page).to have_content "Tool4"
    # And when I click "Checkout"
    click_on "Checkout Now"
    # Then the order should be placed

    # And my current page should be "/orders"
    assert_equal orders_path, current_path
    # And I should see a message "Order was successfully placed"
    expect(page).to have_content "Order was successfully placed"

    # And I should see the order I just placed in a table
    assert_equal 1, Order.count
    order = Order.last
    assert_equal "Tool0", OrderTools.find_by(order_id: order.id).tools.first.na


  end
end
