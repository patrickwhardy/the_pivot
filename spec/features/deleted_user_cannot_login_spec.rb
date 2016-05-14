require "rails_helper"

RSpec.feature "User can login" do
  context "Active User" do
    scenario "with valid credentials is redirected to dashboard" do
      user = create(:user)

      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Login"

      expect(current_path).to eq(dashboard_path(user.slug))
      expect(page).to have_content("Login successful")
    end

    scenario "with invalid credentials is shown error message" do
      user = create(:user)

      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "X"
      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid email/password combination")
    end
  end

  context "Deleted user" do
    scenario "is shown error page" do
      user = create(:deleted_user)

      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.username
      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid email/password combination")
    end
  end
end
