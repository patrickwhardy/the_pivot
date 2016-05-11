require "rails_helper"
# As a logged-in user,
# if I visit /a-specific-tiny-home,
# I can select a checkin date,
# I can select a checkout date,
# and then if I click "Add to Cart",
# I get a message on the same page that added the reservation,
# I see 1 item in my cart,
# I see the cart updated with the new total cost,
# and then if I click on "My Cart",
# I can click "Checkout",
# and then I am on my user dashboard page,
# and can see that reservation in my upcoming reservations list.

RSpec.feature "User can make a single reservation" do
  scenario "A logged in user makes a reservation" do
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
save_and_open_page
    expect(current_path).to eq(dashboard_path(user.slug))
    expect(page).to have_content(checkin_date)
    expect(page).to have_content(checkout_date)
    expect(page).to have_content(home.name)
  end
end
