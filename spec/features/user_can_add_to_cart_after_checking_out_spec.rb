require "rails_helper"

RSpec.feature "User can checkout and add to cart again" do
  scenario "user checks out and adds to cart again" do
    user = create(:user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    first_home = create(:home)
    second_home = create(:home)
    first_home_owner = first_home.user
    second_home_owner = second_home.user
    visit user_home_path(first_home_owner.slug, first_home)

    first_checkin = Date.parse("2017-05-02")
    first_checkout = Date.parse("2017-06-05")
    second_checkin = Date.parse("2018-05-02")
    second_checkout = Date.parse("2018-06-05")    
    year_one = "2017"
    year_two = "2018"
    month_in = "May"
    day_in = "2"
    month_out = "June"
    day_out = "5"

    select year_one, from: "checkin_date_date_1i"
    select month_in, from: "checkin_date_date_2i"
    select day_in, from: "checkin_date_date_3i"

    select year_one, from: "checkout_date_date_1i"
    select month_out, from: "checkout_date_date_2i"
    select day_out, from: "checkout_date_date_3i"

    click_on("Add to Cart")
    click_on("1 Reservation - $3,400.00")
    click_link("Checkout Now")

    expect(current_path).to eq(dashboard_path(user.slug))
    expect(page).to have_content(first_checkin)
    expect(page).to have_content(first_checkout)
    expect(page).to have_content(first_home.name)

    visit user_home_path(second_home_owner.slug, second_home)

    select year_two, from: "checkin_date_date_1i"
    select month_in, from: "checkin_date_date_2i"
    select day_in, from: "checkin_date_date_3i"

    select year_two, from: "checkout_date_date_1i"
    select month_out, from: "checkout_date_date_2i"
    select day_out, from: "checkout_date_date_3i"

    click_on("Add to Cart")
    click_on("1 Reservation - $3,400.00")
    click_link("Checkout Now")

    expect(current_path).to eq(dashboard_path(user.slug))
    expect(page).to have_content(second_checkin)
    expect(page).to have_content(second_checkout)
    expect(page).to have_content(second_home.name)    
    
  end
end
