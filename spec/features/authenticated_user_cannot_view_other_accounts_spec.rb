require "rails_helper"

RSpec.feature "Authenticated user logs in" do
  include SpecTestHelper

  scenario "cannot view other accounts" do
    user1 = create(:user, username: "Tom")
    user2 = create(:user, username: "Susan")
    login_user(user1)
    visit dashboard_path(user2.id)

    expect(page).to have_content user1.username
    expect(page).to have_no_content user2.username

    visit admin_dashboard_path

    expect(page).to have_no_content "Admin"
  end
end
