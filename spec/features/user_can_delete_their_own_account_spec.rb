require "rails_helper"

RSpec.feature "User can delete their account" do
  scenario "They can delete their own account" do
    user = create(:user)
    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    visit dashboard_path(user.slug)
    click_on "Delete Account"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Account successfully deleted")
    expect(page).to have_content("Login")

    deleted_user = User.find(user.id)
    expect(deleted_user.deleted?).to eq(true)
  end
end
