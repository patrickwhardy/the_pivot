require "rails_helper"
RSpec.feature "Admin can login" do
  # As an Admin
  #       When I log in
  #       Then I am redirected to "/admin/dashboard"
  scenario "already has account" do
    admin = User.create(role: 1)
    visit login_path
    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    within(".login") do
      click_on "Login"
    end
    assert_equal "/admin/dashboard", current_path
  end
end
