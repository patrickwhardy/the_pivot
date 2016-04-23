require "rails_helper"

RSpec.feature "Unauthenticated user logs in" do
  include SpecTestHelper

  scenario "cannot view other accounts" do
    user = create(:user, username: "Susan")
    # Background: An unauthenticated user and the ability to add an admin user
    #   As an Authenticated User
    #   I cannot view another user's private data (current or past orders, etc)
    visit dashboard_path(user.id)
    expect(page).to have_no_content user.username
    #   I cannot view the administrator screens or use admin functionality
    visit admin_dashboard_path
    expect(page).to have_no_content "Admin"
    #   I cannot make myself an admin
    add_tools_to_cart(1)
    click_on "Item"
    click_on "Checkout"
    assert_equal cart_login_path, current_path
  end
end
