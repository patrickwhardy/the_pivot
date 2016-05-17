require "rails_helper"

RSpec.feature "User can create a home" do
  context "with valid home information" do
    it "redirects to the show page for that home" do
      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      visit new_user_home_path(user)
      fill_in "Name", with: "My Home"
      fill_in "Description", with: "My Description"
      fill_in :price, with: "100"
      fill_in :address, with: "My Address"
      attach_file "Image", "spec/asset_specs/photos/photo.jpeg"
      click_button "Create Home"
      expect(current_path).to eq(user_home_path(user.slug, Home.last.id))
      expect(page).to have_content("Home successfully created.")
      expect(page).to have_content("My Home")
    end
  end
  context "with invalid home information" do
    it "redirects back to home creation page" do
      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      visit new_user_home_path(user)
      fill_in "Description", with: "My Description"
      fill_in :price, with: "100"
      fill_in :address, with: "My Address"
      click_button "Create Home"
      expect(current_path).to eq(new_user_home_path(user))
      expect(page).to have_content("Name can't be blank")
    end
  end
end
