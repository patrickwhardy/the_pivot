
require "rails_helper"

RSpec.feature "Guest user must login before checking out" do
  include SpecTestHelper
  scenario "has tools in cart" do
    # As a visitor when I have items in my cart
    # And when I visit "/cart"
    # I should not see an option to "Checkout"
    # I should see an option to "Login or Create Account to Checkout"
    # After I create an account
    # And I visit "/cart
    # Then I should see all of the data that was there when I was not logged in
    # When I click "Logout"
    # Then I should see see "Login"
    # And I should not see "Logout"
    username = "User"
    password = "password"
    add_tools_to_cart(3)
    total_price = @tools[0].price + @tools[1].price + @tools[2].price
    visit cart_path

    expect(page).to have_content("Login or Create Account to Checkout")

    click_on "Login or Create Account to Checkout"
    assert_equal cart_login_path, current_path
    # save_and_open_page
    click_on "Create Account"
    fill_in "Username", with: username
    fill_in "Password", with: password
    within(".new-user") do
      click_on "Login"
    end
    assert_equal username, User.last.username

    click_on "Items"
    expect(page).to have_content @tools[0].name
    expect(page).to have_content @tools[1].name
    expect(page).to have_content @tools[2].name
    expect(page).to have_content "Total: #{total_price}"

    click_on "Logout"
    expect(page).to have_no_content "Logout"
    expect(page).to have_content "Login"
  end
end
