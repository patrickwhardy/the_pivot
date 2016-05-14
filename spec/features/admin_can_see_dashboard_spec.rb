require "rails_helper"

RSpec.feature "Admin can see dashboard" do
  scenario "logged in" do
    admin_user = create(:user)
    admin_role = create(:role, role: "admin")
    UserRole.create(user: admin_user, role: admin_role)
    ApplicationController.any_instance.stubs(:current_user).returns(admin_user)
    visit dashboard_path(admin_user.slug)

    expect(page).to have_content("Welcome, #{admin_user.first_name}")
    expect(page).to have_content("View All Owners")
    expect(page).to have_content("View All Homes")
  end

  scenario "non-admin user logged in" do
    admin_user = create(:user, first_name: "admin")
    admin_role = create(:role, role: "admin")
    UserRole.create(user: admin_user, role: admin_role)
    regular_user = create(:user, first_name: "regular")
    regular_role = create(:role, role: "user")
    UserRole.create(user: regular_user, role: regular_role)
    ApplicationController.any_instance.stubs(:current_user).returns(regular_user)
    visit dashboard_path(admin_user.slug)

    expect(current_path).to eq(root_path)
  end
end
