require "rails_helper"

RSpec.feature "Admin can see dashboard" do
  scenario "logged in" do
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit dashboard_path(admin.slug)

    expect(page).to have_content("Welcome, #{admin.first_name}")
    expect(page).to have_content("View All Owners")
    expect(page).to have_content("View All Homes")
  end

  scenario "non-admin user logged in" do
    admin = create(:admin)
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path(admin.slug)

    expect(current_path).to eq(root_path)
  end
end
