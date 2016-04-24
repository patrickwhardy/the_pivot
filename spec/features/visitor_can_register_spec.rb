require "rails_helper"

RSpec.feature "Visitor comes to site to register" do
  scenario "correctly provides username and password" do
    username = "visitor"
    password = "password"
    visit new_user_path
    fill_in "Username", with: username
    fill_in "Password", with: password
    within ".new-user" do
      click_on "Login"
    end

    assert_equal username, User.last.username
    assert_equal dashboard_path(User.last), current_path
  end

  scenario "does not provide password" do
    username = "visitor"
    visit new_user_path
    fill_in "Username", with: username
    within ".new-user" do
      click_on "Login"
    end

    assert_equal 0, User.count
    expect(page).to have_content "New User Page"
    expect(page).to have_content "Username and password are required to create an account."
  end

  scenario "does not provide password" do
    password = "password"
    visit new_user_path
    fill_in "Password", with: password
    within ".new-user" do
      click_on "Login"
    end

    assert_equal 0, User.count
    expect(page).to have_content "New User Page"
    expect(page).to have_content "Username and password are required to create an account."
  end
end
