require "rails_helper"

RSpec.feature "User can edit their account" do
  scenario "They edit their own account" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit dashboard_path(user.slug)
    click_on "Edit Account"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Username", with: "new username"
    fill_in "First name", with: "new first name"
    fill_in "Last name", with: "new last name"
    attach_file "Avatar", "spec/asset_specs/photos/photo.jpeg"
    click_button "Edit Account"

    expect(current_path).to eq("/new-username/dashboard")
    expect(page).to have_content("Account successfully updated")
    expect(page).to have_content("Welcome, new first name")
  end

  scenario "They cannot reach the edit page of other users" do
    user_one = create(:user)
    user_two = create(:user)

    ApplicationController.any_instance.stubs(:current_user).returns(user_one)
    visit edit_user_path(user_two.slug)
    expect(page).not_to have_content("Edit #{user_two.username}'s Account")
    expect(current_path).to eq(root_path)
  end

  scenario "Guest user cannot reach edit page" do
    user = create(:user)

    visit edit_user_path(user.slug)
    expect(page).not_to have_content("Edit #{user.username}'s Account")
    expect(current_path).to eq(root_path)
  end
end
