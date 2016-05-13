require "rails_helper"
# As a logged-in owner,
# when I go to my user dashboard,
# I can click "View all homes,"
# and then am taken to the owner show page,
# and under each home I see the buttons "edit" and "delete".
RSpec.feature "user can view profiles" do
  it "owner views their profile" do
    user = create(:user)
    4.times do
      home = create(:home)
      home.user = user
      home.save
    end

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path(user)
    click_on("View All Homes")
    expect(current_path).to eq(user_homes_path(user.slug))
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.avatar)
    expect(page).to have_content(user.description)

    user.homes.each do |home|
      expect(page).to have_content(home.photos.first.image.url)
      expect(page).to have_content(home.name)
      expect(page).to have_content(home.description)
    end
  end
end
