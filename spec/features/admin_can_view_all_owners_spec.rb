require "rails_helper"

RSpec.feature "Admin is logged in" do
  scenario "goes to view all owners" do
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    home_one = create(:home, name: "home 1")
    home_two = create(:home, name: "home 2")
    home_three = create(:home, name: "home 3", user: home_one.user)
    homeless_user = create(:user)

    visit dashboard_path(admin.slug)
    click_on "View All Owners"

    expect(current_path).to eq(admin_owners_path)
    within(".user-#{home_one.user.id}") do
      expect(page).to have_content(home_one.user.username)
      expect(page).to have_link("User Dashboard", href: dashboard_path(home_one.user.slug))
      expect(page).to have_link("User Homes", href: user_homes_path(home_one.user.slug))
      expect(page).to have_content("Edit")
      expect(page).to have_content("Delete")
    end
    within(".user-#{home_two.user.id}") do
      expect(page).to have_content(home_two.user.username)
      expect(page).to have_link("User Dashboard", href: dashboard_path(home_two.user.slug))
      expect(page).to have_link("User Homes", href: user_homes_path(home_two.user.slug))
      expect(page).to have_content("Edit")
      expect(page).to have_content("Delete")
    end
    expect(page).to have_no_content(homeless_user.username)
  end

  scenario "regular user is logged in" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_owners_path
    expect(current_path).to eq(root_path)
  end
end
