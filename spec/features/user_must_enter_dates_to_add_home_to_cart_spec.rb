require "rails_helper"

RSpec.describe "user wants to add a home to his cart" do
  scenario "user does not give checkin date" do
      home = create(:home)
      home_owner = home.user
      visit user_home_path(home_owner.slug, home)

      checkout_date = Date.parse("2017-05-06")

      fill_in "date_checkout_date", with: "05/06/2017"

      expect(page).to have_content("0 Reservations - $0.00")
      click_on("Add to Cart")
      expect(current_path).to eq(user_home_path(home_owner.slug, home))
      expect(page).to have_content("You must have a checkin and checkout date")
      expect(page).to have_content("0 Reservations - $0.00")    
  end

  scenario "user does not give checkout date" do
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
  end

  scenario "user does not give either checkin or checkout" do
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
  end

end
