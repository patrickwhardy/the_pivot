require "rails_helper"

RSpec.feature "Admin logged in" do
  include SpecTestHelper

  scenario "redirects to admin dashboard" do
    admin = create(:user, role: 1)
    login_user(admin)
    new_username = "nonsense"
    new_password = "more nonsense"
    login_user(admin)

    click_on "Update My Account"
    fill_in "Username", with: "nonsense"
    fill_in "Password", with: "more nonsense"
    click_on "Update My Account"

    assert_equal admin_dashboard_path, current_path

    visit root_path
    click_on "My Dashboard"

    assert_equal admin_dashboard_path, current_path
  end
end
