require "rails_helper"

RSpec.feature "Admin can modify user or owner" do

  before :each do
    @admin_user = create(:user)
    admin_role = create(:role, role: "admin")
    UserRole.create(user: @admin_user, role: admin_role)

    @owner = create(:user)
    @owner.homes << create(:home)
  end
  
  scenario "Admin wants to edit owner" do
    ApplicationController.any_instance.stubs(:current_user).returns(@admin_user)    
    visit dashboard_path(@admin_user.slug)
    click_on "View All Owners"
    within ".user-#{@owner.id}" do
      click_on "Edit"
    end
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

  scenario "Admin wants to delete owner" do
    ApplicationController.any_instance.stubs(:current_user).returns(@admin_user)
    visit dashboard_path(@admin_user.slug)
    click_on "View All Owners"
    within ".user-#{@owner.id}" do
      click_on "Delete"
    end
    # insert expected functions after deleting user
    expect(true).to eq false
  end

  scenario "Admin wants to edit user" do
    ApplicationController.any_instance.stubs(:current_user).returns(@admin_user)    
    visit dashboard_path(@admin_user.slug)
    click_on "View All Users"
    within ".user-#{@owner.id}" do
      click_on "Edit"
    end
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

  scenario "Admin wants to delete user" do
  end
end
