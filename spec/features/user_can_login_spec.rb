require "rails_helper"

RSpec.feature "User can login" do
  scenario "user already has account" do

    username = "username"
    password = "password"
    visit login_path
    click_on "Create Account"

    fill_in "Username", with: username
    fill_in "Password", with: password
    within(".new-user") do
      click_on "Login"
    end
  
    user = User.last
    assert_equal dashboard_path(user.id), current_path
    expect(page).to have_content "Welcome to ToolChest, #{user.username.capitalize}"
    within(".user-info") do
      expect(page).to have_content user.username.capitalize
    end
    expect(page).to have_no_content "Login"
    expect(page).to have_content "Logout"
    click_on "Logout"
    assert_equal root_path, current_path
    expect(page).to have_content "Login"
  end

  scenario "types wrong password" do
    user = create(:user, password: "password")
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "wrong"
    within(".login") do
      click_on "Login"
    end

    assert_equal login_path, current_path
    expect(page).to have_content "Invalid email/password combination"
  end

  scenario "types wrong username" do
    user = create(:user, username: "username")
    visit login_path
    fill_in "Username", with: "wrong"
    fill_in "Password", with: user.password
    within(".login") do
      click_on "Login"
    end

    assert_equal login_path, current_path
    expect(page).to have_content "Invalid email/password combination"
  end
end
