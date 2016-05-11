require "rails_helper"

RSpec.feature "User can create an account" do
  context "With valid user information" do
    it "creates the account and takes the user to his dashboard" do
      visit new_user_path
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "password"
      fill_in "Username", with: "username"
      fill_in "First name", with: "first name"
      fill_in "Last name", with: "last name"
      attach_file "Avatar", "spec/asset_specs/photos/photo.jpeg"
      click_button "Create Account"

      expect(current_path).to eq(dashboard_path(User.last.id))
      expect(page).to have_content("Welcome, first name")
    end
  end

  context "With invalid user information" do
    it "stays on current page and tells the user what information is missing" do

      visit new_user_path
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "password"
      fill_in "First name", with: "first name"
      fill_in "Last name", with: "last name"
      click_button "Create Account"

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Username can't be blank")
    end
  end
end
