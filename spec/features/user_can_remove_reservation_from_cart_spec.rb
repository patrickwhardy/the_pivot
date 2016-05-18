require "rails_helper"

RSpec.feature "User can remove reservation from cart" do
  context "as a guest user" do
    scenario "makes a reservation and removes it" do
      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      home = create(:home)
      home_owner = home.user
      visit user_home_path(home_owner.slug, home)

      checkin_date = Date.parse("2017-05-02")
      checkout_date = Date.parse("2017-05-06")

      fill_in "date_checkin_date", with: "05/02/2017"
      fill_in "date_checkout_date", with: "05/06/2017"

      click_on("Add to Cart")

      click_on("1 Reservation - $400.00")

      expect(current_path).to eq(cart_path)

      click_on("Remove From Cart")

      expect(page).to_not have_content("1 Reservation - $400")
    end
  end
end
