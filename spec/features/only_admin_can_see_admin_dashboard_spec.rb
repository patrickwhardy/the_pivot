require "rails_helper"

# As an Admin
#       When I visit "/admin/dashboard"
#       I will see a heading on the page that says "Admin Dashboard"
#       As a registered user
#       When I visit "/admin/dashboard"
#       I get a 404
#       As an unregistered user
#       When I visit "/admin/dashboard"
#       I get a 404

RSpec.feature "Admin has a dashboard" do
  include SpecTestHelper

  scenario "admin can view it" do
    admin = create(:user, role: 1)
    login_user(admin)

    assert_equal admin_dashboard_path, current_path
    within "h1" do
      expect(page).to have_content "Admin Dashboard"
    end
  end

  scenario "logged in user can't see it" do
    user = create(:user)
    login_user(user)

    visit admin_dashboard_path
    expect(page).to have_content "The page you were looking for doesn't exist (404)"
  end

  scenario "non-logged-in user can't see it" do
    visit admin_dashboard_path
    expect(page).to have_content "The page you were looking for doesn't exist (404)"    
  end
end
