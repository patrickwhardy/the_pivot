require "rails_helper"

RSpec.feature "User with account tries to log in" do
  include SpecTestHelper

  scenario "from cart but types in account info wrong" do
    user = create(:user)
    add_tools_to_cart(1)
    click_on "Item"
    click_on "Login or Create Account to Checkout"
    fill_in "Username", with: "wrong"
    fill_in "Password", with: user.password
    within ".login" do
      click_on "Login"
    end

    assert_equal cart_login_path, current_path
    expect(page).to have_content "Unable to login. Please check your username
                                  and password or create an account."

    fill_in "Username", with: user.username
    fill_in "Password", with: "wrong"
    within ".login" do
      click_on "Login"
    end

    assert_equal cart_login_path, current_path
    expect(page).to have_content "Unable to login. Please check your username
                                  and password or create an account."

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    within ".login" do
      click_on "Login"
    end

    assert_equal cart_path, current_path
  end

  scenario "not from cart but types in account info wrong" do
    user = create(:user)
    visit login_path
    fill_in "Username", with: "wrong"
    fill_in "Password", with: user.password
    within ".login" do
      click_on "Login"
    end

    assert_equal login_path, current_path
    expect(page).to have_content "Invalid email/password combination"

    fill_in "Username", with: user.username
    fill_in "Password", with: "wrong"
    within ".login" do
      click_on "Login"
    end

    assert_equal login_path, current_path
    expect(page).to have_content "Invalid email/password combination"

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    within ".login" do
      click_on "Login"
    end

    assert_equal dashboard_path(user.id), current_path
  end
end
