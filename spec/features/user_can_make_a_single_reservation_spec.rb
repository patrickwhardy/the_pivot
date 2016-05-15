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
      checkout_date = Date.parse("2017-06-05")
      year = "2017"
      month_in = "May"
      day_in = "2"
      month_out = "June"
      day_out = "5"

      select year, from: "checkin_date_date_1i"
      select month_in, from: "checkin_date_date_2i"
      select day_in, from: "checkin_date_date_3i"

      select year, from: "checkout_date_date_1i"
      select month_out, from: "checkout_date_date_2i"
      select day_out, from: "checkout_date_date_3i"

      expect(page).to have_content("0 Reservations - $0.00")
      click_on("Add to Cart")
      expect(current_path).to eq(user_home_path(home_owner.slug, home))
      expect(page).to have_content("You've added this reservation to your cart")
      expect(page).to have_content("1 Reservation - $3,400.00")

      click_on("1 Reservation - $3,400.00")

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
      checkout_date_one = Date.parse("2017-06-05")
      year = "2017"
      month_in = "May"
      day_in = "2"
      month_out = "June"
      day_out = "5"

      select year, from: "checkin_date_date_1i"
      select month_in, from: "checkin_date_date_2i"
      select day_in, from: "checkin_date_date_3i"

      select year, from: "checkout_date_date_1i"
      select month_out, from: "checkout_date_date_2i"
      select day_out, from: "checkout_date_date_3i"

      click_on("Add to Cart")

      visit user_home_path(home_two.user.slug, home_two)

      checkin_date_two = Date.parse("2017-06-02")
      checkout_date_two = Date.parse("2017-07-05")
      year = "2017"
      month_in = "June"
      day_in = "2"
      month_out = "July"
      day_out = "5"

      select year, from: "checkin_date_date_1i"
      select month_in, from: "checkin_date_date_2i"
      select day_in, from: "checkin_date_date_3i"

      select year, from: "checkout_date_date_1i"
      select month_out, from: "checkout_date_date_2i"
      select day_out, from: "checkout_date_date_3i"

      click_on("Add to Cart")
      click_on("2 Reservations - $6,700.00")

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
      year = "2017"
      month_in = "May"
      day_in = "2"
      month_out = "June"
      day_out = "5"

      select year, from: "checkin_date_date_1i"
      select month_in, from: "checkin_date_date_2i"
      select day_in, from: "checkin_date_date_3i"

      select year, from: "checkout_date_date_1i"
      select month_out, from: "checkout_date_date_2i"
      select day_out, from: "checkout_date_date_3i"

      expect(page).to have_content("0 Reservations - $0.00")
      click_on("Add to Cart")
      expect(current_path).to eq(user_home_path(home_owner.slug, home))
      expect(page).to have_content("You've added this reservation to your cart")
      expect(page).to have_content("1 Reservation - $3,400.00")

      click_on("1 Reservation - $3,400.00")

      expect(current_path).to eq(cart_path)
      click_link("Login or Create Account to Checkout")

      expect(current_path).to eq(new_user_path)
    end
  end
end
