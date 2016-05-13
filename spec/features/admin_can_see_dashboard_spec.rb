require "rails_helper"

RSpec.feature "Admin can see dashboard" do
  scenario "logged in" do
#     As a logged-in admin,
# when I view my dashboard,
# I can see a button to "view all owners,"
# I can see a button to "view all homes,"
    admin_user = create(:user)
    admin_role = create(:role, role: "admin")
    UserRole.create(user: admin_user, role: admin_role)
    ApplicationController.any_instance.stubs(:current_user).returns(admin_user)
    visit dashboard_path(admin_user.slug)

    expect(page).to have_content("Welcome, #{admin_user.first_name}")
    expect(page).to have_content("View All Owners")
    expect(page).to have_content("View All Homes")    
  end
end
