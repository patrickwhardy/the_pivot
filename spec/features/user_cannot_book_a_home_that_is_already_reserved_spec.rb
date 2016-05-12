require "rails_helper"

RSpec.feature "User cannot book a home that is reserved" do
    scenario "The user sees a flash message with dates reserved" do
    user = create(:user)
    home = create(:home)
    order = create(:order)
    checkin_date = Date.parse("2017-05-02")
    checkout_date = Date.parse("2017-05-04")
    reservation = Reservation.create(
      home: home,
      checkin: checkin_date,
      checkout: checkout_date,
      order_id: order.id
    )
    (checkin_date..checkout_date - 1).each do |date|
      reservation.reservation_nights << ReservationNight.new(night: date)
    end
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit user_home_path(home.user.slug, home)
    year = "2017"
    month = "May"
    day_in = "1"
    day_out = "5"

    select year, from: "checkin_date_date_1i"
    select month, from: "checkin_date_date_2i"
    select day_in, from: "checkin_date_date_3i"

    select year, from: "checkout_date_date_1i"
    select month, from: "checkout_date_date_2i"
    select day_out, from: "checkout_date_date_3i"

    click_on("Add to Cart")

    expect(current_path).to eq(user_home_path(home.user.slug, home))
    expect(page).to have_content("0 Reservations - $0.00")
    expect(page).to have_content("This home is already reserved on 2017-05-02, 2017-05-03")
  end
end
