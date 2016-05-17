require "rails_helper"

RSpec.feature "User can visit their cart" do
  scenario "They see their reservations and all total" do
    home_one = create(:home)
    home_two = create(:home)
    visit user_home_path(home_one.user.slug, home_one)

    checkin_date_one = Date.parse("2017-05-02")
    checkout_date_one = Date.parse("2017-05-06")

    fill_in "date_checkin_date", with: "05/02/2017"
    fill_in "date_checkout_date", with: "05/06/2017"

    click_on("Add to Cart")

    visit user_home_path(home_two.user.slug, home_two)

    checkin_date_two = Date.parse("2017-07-05")
    checkout_date_two = Date.parse("2017-07-06")

    fill_in "date_checkin_date", with: "07/05/2017"
    fill_in "date_checkout_date", with: "07/06/2017"

    click_on("Add to Cart")
    click_on("2 Reservations - $500.00")

    expect(current_path).to eq(cart_path)
    within(".home-#{home_one.id}") do
      expect(page).to have_content(home_one.name)
      expect(page).to have_content(checkin_date_one)
      expect(page).to have_content(checkout_date_one)
      expect(page).to have_content("400.00")
    end
    within(".home-#{home_two.id}") do
      expect(page).to have_content(home_two.name)
      expect(page).to have_content(checkin_date_two)
      expect(page).to have_content(checkout_date_two)
      expect(page).to have_content("100.00")
    end
    within(".cart-total") do
      expect(page).to have_content("Total: 500")
    end
  end
end
