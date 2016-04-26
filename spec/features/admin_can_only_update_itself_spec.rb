require "rails_helper"

RSpec.feature "Admin logged in" do
  include SpecTestHelper
  
  scenario "can update its own account" do
    admin = create(:user, role: 1)
    new_username = "nonsense"
    new_password = "more nonsense"
    login_user(admin)
    click_on "Update My Account"

    expect(admin.username).not_to eql(new_username)
    expect(admin.password).not_to eql(new_password)
    assert_equal edit_user_path(admin.id), current_path

    fill_in "Username", with: "nonsense"
    fill_in "Password", with: "more nonsense"
    click_on "Update My Account"

    assert_equal admin_dashboard_path, current_path
    expect(User.find(admin.id).username).to eql(new_username)
    expect(User.find(admin.id).password).to eql(new_password)
  end

  scenario "can't update anothe user's account" do

  end
end
