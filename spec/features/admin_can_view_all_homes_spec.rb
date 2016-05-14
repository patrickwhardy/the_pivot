require "rails_helper"

RSpec.feature "Admin can view all homes" do
  scenario "admin is logged in" do
    admin_user = create(:user)
    admin_role = create(:role, role: "admin")
    UserRole.create(user: admin_user, role: admin_role)
    ApplicationController.any_instance.stubs(:current_user).returns(admin_user)
    home_one = create(:home, name: "home 1")
    home_two = create(:home, name: "home 2")

    visit dashboard_path(admin_user.slug)
    click_on "View All Homes"

    expect(current_path).to eq(admin_homes_path)
    within(".home-#{home_one.id}") do
      expect(page).to have_content(home_one.name)
      expect(page).to have_content(home_one.user.username)
      expect(page).to have_content("Edit")
      expect(page).to have_content("Suspend")
      expect(page).to have_content("Delete")
    end
    within(".home-#{home_two.id}") do
      expect(page).to have_content(home_two.name)
      expect(page).to have_content(home_two.user.username)
      expect(page).to have_content("Edit")
      expect(page).to have_content("Suspend")
      expect(page).to have_content("Delete")
    end
  end

  scenario "regular user is logged in" do
    admin_user = create(:user, first_name: "admin")
    admin_role = create(:role, role: "admin")
    UserRole.create(user: admin_user, role: admin_role)
    regular_user = create(:user, first_name: "regular")
    regular_role = create(:role, role: "user")
    UserRole.create(user: regular_user, role: regular_role)
    ApplicationController.any_instance.stubs(:current_user).returns(regular_user)

    visit admin_homes_path
    expect(page).to have_content("404")
  end
end
