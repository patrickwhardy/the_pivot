require "rails_helper"

RSpec.feature "Admin can view all homes" do
  scenario "admin is logged in" do
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    home_one = create(:home, name: "home 1")
    home_two = create(:home, name: "home 2")

    visit dashboard_path(admin.slug)
    click_on "View All Homes"

    expect(current_path).to eq(admin_homes_path)
    within(".home-#{home_one.id}") do
      expect(page).to have_content(home_one.name)
      expect(page).to have_content(home_one.user.username)
      expect(page).to have_content("Edit")
      expect(page).to have_content("Suspend")
    end
    within(".home-#{home_two.id}") do
      expect(page).to have_content(home_two.name)
      expect(page).to have_content(home_two.user.username)
      expect(page).to have_content("Edit")
      expect(page).to have_content("Suspend")
    end
  end

  scenario "regular user is logged in" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_homes_path
    expect(current_path).to eq(root_path)
  end
end
