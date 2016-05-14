require "rails_helper"

RSpec.feature "Admin can suspend a home" do
  scenario "Admin is logged in" do
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    home = create(:home, name: "home 1")

    visit dashboard_path(admin.slug)
    click_on "View All Homes"

    within(".home-#{home.id}") do
      click_on("Suspend")
    end

    expect(page).to have_content "#{home.name} has been suspended"
    within(".home-#{home.id}") do
      expect(page).to have_content("Reactivate")
    end

    ApplicationController.any_instance.stubs(:current_user).returns(nil)

    visit user_home_path(home.user.slug, home.id)

    expect(page).to have_no_content("Add to Cart")
    expect(page).to have_content("This home has been suspended.")

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit dashboard_path(admin.slug)
    click_on "View All Homes"

    within(".home-#{home.id}") do
      click_on("Reactivate")
      expect(page).to have_no_content("Suspend")
    end
    expect(page).to have_content "#{home.name} is reactivated"

    ApplicationController.any_instance.stubs(:current_user).returns(nil)
    visit user_home_path(home.user.slug, home.id)
    expect(page).to have_button("Add to Cart")
  end
end
