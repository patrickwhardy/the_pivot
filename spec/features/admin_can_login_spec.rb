require "rails_helper"

RSpec.feature "Admin can login" do
  scenario "already has account" do
    admin = create(:user, role: 1)
    visit login_path
    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    within(".login") do
      click_on "Login"
    end
    assert_equal "/admin/dashboard", current_path
  end
end
