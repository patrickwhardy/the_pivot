require "rails_helper"

RSpec.feature "User can visit their cart" do
  scenario "They see their reservations and all total" do
  #   As a user,
  # after I make a valid reservation,
  # when I go to my cart,
  # I should see a list of homes I am reserving,
  # the dates of those reservations,
  # the subtotal for each reservation,
  # and the total price for all reservations.
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
    within(".home-#{home_one.id}") do
      expect(page).to have_content(home_one.name)
      expect(page).to have_content(checkin_date_one)
      expect(page).to have_content(checkout_date_one)
      expect(page).to have_content("3400.00")
    end
    within(".home-#{home_two.id}") do
      expect(page).to have_content(home_two.name)
      expect(page).to have_content(checkin_date_two)
      expect(page).to have_content(checkout_date_two)
      expect(page).to have_content("3300.00")
    end
    within(".cart-total") do
      expect(page).to have_content("Total: 6700")
    end
  end
end
