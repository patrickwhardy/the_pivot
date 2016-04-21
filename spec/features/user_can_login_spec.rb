require "rails_helper"

RSpec.feature "User can login" do
  scenario "user already has account" do
#     As a visitor
# When I visit "/login
# And when I click link "Create Account"
# And I fill in my desired credentials
# And I submit my information
# Then my current page should be "/dashboard"
# And I should see a message in the navbar that says "Logged in as SOME_USER"
# And I should see my profile information
# And I should not see a link for "Login"
# And I should see a link for "Logout"
    user = create(:user)
    visit login_path
    click_on "Create Account"
    # path is new_user_path
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Login"

    assert_equal dashboard_path(user.id), current_path
    expect(page).to have_content "Logged in as #{user.username}"
    within(".user-info") do
      expect(page).to have_content user.username
    end
    expect(page).to have_no_content "Login"
    expect(page).to have_content "Logout"
  end
end
