require "rails_helper"

RSpec.feature "Admin can see dashboard" do
  scenario "logged in" do
#     As a logged-in admin,
# when I view my dashboard,
# I can see a button to "view all owners,"
# I can see a button to "view all homes,"
    admin = create(:user)
    UserRole.create(user: admin, role: 1)
    ApplicationController.any_instance.stubs(:current_user).return(admin)
    visit dashboard_path(admin.slug)

    expect(page).to have_content("View All Owners")
    expect(page).to have_content("View All Homes")    
  end
end
