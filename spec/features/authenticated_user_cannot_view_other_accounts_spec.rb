require "rails_helper"

RSpec.feature "Authenticated logs in" do
  include SpecTestHelper

  scenario "cannot view other accounts" do
    user1 = create(:user, username: "Tom")
    user2 = create(:user, username: "Susan")
    # Background: An authenticated user and the ability to add an admin user
    #   As an Authenticated User

    login_user(user1)
    #   I cannot view another user's private data (current or past orders, etc)
    visit dashboard_path(user2.id)
    expect(page).to have_content user1.username
    expect(page).to have_no_content user2.username
    #   I cannot view the administrator screens or use admin functionality
    visit admin_dashboard_path
    expect(page).to have_no_content "Admin"
    #   I cannot make myself an admin




  end
end
