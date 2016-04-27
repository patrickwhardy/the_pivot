require "rails_helper"

RSpec.feature "Unauthenticated user logs in" do
  include SpecTestHelper

  scenario "cannot view other accounts" do
    user = create(:user, username: "Susan")
    visit dashboard_path(user.id)

    expect(page).to have_no_content user.username

    visit admin_dashboard_path
    
    expect(page).to have_no_content "Admin"

    add_tools_to_cart(1)
    click_on "Item"
    click_on "Checkout"
    assert_equal cart_login_path, current_path
  end
end
