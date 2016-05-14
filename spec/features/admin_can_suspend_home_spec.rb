require "rails_helper"

RSpec.feature "Admin can suspend a home" do
  scenario "Admin is logged in" do
    admin_user = create(:user)
    admin_role = create(:role, role: "admin")
    UserRole.create(user: admin_user, role: admin_role)
    ApplicationController.any_instance.stubs(:current_user).returns(admin_user)
    home_one = create(:home, name: "home 1")

    visit dashboard_path(admin_user.slug)
    click_on "View All Homes"

    within(".home-#{home_one.id}") do
      click_on("Suspend")
    end

    ApplicationController.any_instance.stubs(:current_user).returns(nil)

    visit user_home_path(home_one.user.slug, home_one.id)
    
    expect(page).to have_no_content("Add to Cart")
    expect(page).to have_content("This home has been suspended.")
  end
end

