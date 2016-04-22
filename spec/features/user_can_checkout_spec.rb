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
    click_on "Checkout"
    fill_in "Username", user.username
    fill_in "Password", user.password
    click_on "Login"

    # Then I should be required to login
    # When I am logged in I should be taken back to my cart
    # And when I click "Checkout"
    # Then the order should be placed
    # And my current page should be "/orders"
    # And I should see a message "Order was successfully placed"
    # And I should see the order I just placed in a table


  end
end
