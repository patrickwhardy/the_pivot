require "rails_helper"

RSpec.feature "User can edit a home" do
  scenario "They edit their own home" do
    home = create(:home)
    user = home.user
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit user_homes_path(user.slug)
    click_on "Edit Home"
    fill_in "Name", with: "Updated Home Name"
    fill_in "Description", with: "Updated Description"
    fill_in "Price per night", with: "20"
    fill_in "Address", with: "Updated Address"
    attach_file "Image", "spec/asset_specs/photos/photo.jpeg"
    click_button "Edit Home"

    expect(current_path).to eq(user_home_path(user.slug, home))
    expect(page).to have_content("Home successfully updated")
    expect(page).to have_content("Updated Home Name")
    expect(page).to have_content("Updated Description")
  end

  scenario "They cannot reach the home edit page of other users" do
    user = create(:user)
    home = create(:home)

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit edit_user_home_path(home.user.slug, home)
    expect(page).not_to have_content("Edit #{home.name}")
    expect(current_path).to eq(root_path)
  end

  scenario "Guest user cannot reach the home edit page" do
    home = create(:home)

    visit edit_user_home_path(home.user.slug, home)
    expect(page).not_to have_content("Edit #{home.name}")
    expect(current_path).to eq(root_path)
  end
end
