require "rails_helper"

RSpec.feature "User can make reservations" do
  context "as a logged in user" do
    scenario "makes a reservation and sees it on their dashboard" do
      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      home = create(:home)
      home_owner = home.user
      visit user_home_path(home_owner.slug, home)

      checkin_date = Date.parse("2017-05-02")
      checkout_date = Date.parse("2017-05-06")

      fill_in "date_checkin_date", with: "05/02/2017"
      fill_in "date_checkout_date", with: "05/06/2017"

      expect(page).to have_content("0 Reservations - $0.00")
      click_on("Add to Cart")
      expect(current_path).to eq(user_home_path(home_owner.slug, home))
      expect(page).to have_content("You've added this reservation to your cart")
      expect(page).to have_content("1 Reservation - $400.00")

      click_on("1 Reservation - $400.00")

      expect(current_path).to eq(cart_path)
      click_link("Checkout Now")

      expect(current_path).to eq(dashboard_path(user.slug))
      expect(page).to have_content(checkin_date)
      expect(page).to have_content(checkout_date)
      expect(page).to have_content(home.name)
    end

    scenario "makes multiple reservations from different homeowners" do
      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      home_one = create(:home)
      home_two = create(:home)
      visit user_home_path(home_one.user.slug, home_one)

      checkin_date_one = Date.parse("2017-05-02")
      checkout_date_one = Date.parse("2017-05-06")


      fill_in "date_checkin_date", with: "05/02/2017"
      fill_in "date_checkout_date", with: "05/06/2017"

      click_on("Add to Cart")

      visit user_home_path(home_two.user.slug, home_two)

      checkin_date_two = Date.parse("2017-06-02")
      checkout_date_two = Date.parse("2017-07-07")


      fill_in "date_checkin_date", with: "06/02/2017"
      fill_in "date_checkout_date", with: "07/07/2017"

      click_on("Add to Cart")
      click_on("2 Reservations - $3900.00")

      expect(current_path).to eq(cart_path)
      click_link("Checkout Now")

      expect(current_path).to eq(dashboard_path(user.slug))
      expect(page).to have_content(checkin_date_one)
      expect(page).to have_content(checkout_date_one)
      expect(page).to have_content(home_one.name)
      expect(page).to have_content(home_two.name)
      expect(page).to have_content(checkin_date_two)
      expect(page).to have_content(checkout_date_two)
    end
  end

  context "as a guest user" do
    scenario "they are directed to make an account when making a reservation" do
      user = create(:user)
      home = create(:home)
      home_owner = home.user
      visit user_home_path(home_owner.slug, home)

      checkin_date = Date.parse("2017-05-02")
      checkout_date = Date.parse("2017-06-05")

      fill_in "date_checkin_date", with: "05/02/2017"
      fill_in "date_checkout_date", with: "05/06/2017"

      expect(page).to have_content("0 Reservations - $0.00")
      click_on("Add to Cart")
      expect(current_path).to eq(user_home_path(home_owner.slug, home))
      expect(page).to have_content("You've added this reservation to your cart")
      expect(page).to have_content("1 Reservation - $400.00")

      click_on("1 Reservation - $400.00")

      expect(current_path).to eq(cart_path)
      expect(page).to have_link("Login")
      click_link("Signup")

      expect(current_path).to eq(new_user_path)
    end
  end
end
