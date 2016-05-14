require "rails_helper"

RSpec.feature "Admin is logged in" do
  scenario "goes to view all owners" do
     admin_user = create(:user)
    admin_role = create(:role, role: "admin")
    UserRole.create(user: admin_user, role: admin_role)
    ApplicationController.any_instance.stubs(:current_user).returns(admin_user)
    home_one = create(:home, name: "home 1")
    home_two = create(:home, name: "home 2")
    home_three = create(:home, name: "home 3", user: home_one.user)
    homeless_user = create(:user)

    visit dashboard_path(admin_user.slug)
    click_on "View All Owners"

    expect(current_path).to eq(admin_owners_path)
    within(".owner-#{home_one.user.id}") do
      expect(page).to have_content(home_one.user.username)
      expect(page).to have_link("User Dashboard", href: dashboard_path(home_one.user.slug))
      expect(page).to have_link("User Homes", href: user_homes_path(home_one.user.slug))
      expect(page).to have_content("Edit")
      expect(page).to have_content("Delete")
    end
    within(".owner-#{home_two.user.id}") do
      expect(page).to have_content(home_two.user.username)
      expect(page).to have_link("User Dashboard", href: dashboard_path(home_two.user.slug))
      expect(page).to have_link("User Homes", href: user_homes_path(home_two.user.slug))
      expect(page).to have_content("Edit")
      expect(page).to have_content("Delete")
    end
    expect(page).to have_no_content(homeless_user.username)
  end

  scenario "regular user is logged in" do
    admin_user = create(:user, first_name: "admin")
    admin_role = create(:role, role: "admin")
    UserRole.create(user: admin_user, role: admin_role)
    regular_user = create(:user, first_name: "regular")
    regular_role = create(:role, role: "user")
    UserRole.create(user: regular_user, role: regular_role)
    ApplicationController.any_instance.stubs(:current_user).returns(regular_user)

    visit admin_owners_path
    expect(page).to have_content("404")
  end
end
