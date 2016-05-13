require "rails_helper"

RSpec.feature "User sees reservation tables on dashboard" do
  it "shows the user reservations" do
    order = create(:order)
    user = order.user
    home = create(:home)

    order.reservations << Reservation.new(
          checkin: Date.parse("2017-05-22"),
          checkout: Date.parse("2017-05-25"),
          home: home
    )

    order.reservations << Reservation.new(
          checkin: Date.parse("2015-05-22"),
          checkout: Date.parse("2015-05-25"),
          home: home
    )

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path(user)

    within ".upcoming-reservations" do
      expect(page).to have_content(order.reservations.first.checkin)
      expect(page).to have_content(order.reservations.first.checkout)
      expect(page).not_to have_content(order.reservations.last.checkin)
      expect(page).not_to have_content(order.reservations.last.checkout)
    end

    within ".past-reservations" do
      expect(page).to have_content(order.reservations.last.checkin)
      expect(page).to have_content(order.reservations.last.checkout)
      expect(page).not_to have_content(order.reservations.first.checkin)
      expect(page).not_to have_content(order.reservations.first.checkout)
    end

    click_on("Add a Home")
    expect(current_path).to eq(new_user_home_path(user.slug))
  end

  it "shows owner their home's reservations" do
    home = create(:home)
    owner = home.user
    order = create(:order)

    order.reservations << Reservation.new(
          checkin: Date.parse("2017-05-22"),
          checkout: Date.parse("2017-05-25"),
          home: home
    )

    order.reservations << Reservation.new(
          checkin: Date.parse("2015-05-22"),
          checkout: Date.parse("2015-05-25"),
          home: home
    )

    ApplicationController.any_instance.stubs(:current_user).returns(owner)
    visit dashboard_path(owner)

    within ".homes-upcoming-reservations" do
      expect(page).to have_content(order.reservations.first.checkin)
      expect(page).to have_content(order.reservations.first.checkout)
      expect(page).not_to have_content(order.reservations.last.checkin)
      expect(page).not_to have_content(order.reservations.last.checkout)
    end

    within ".homes-past-reservations" do
      expect(page).to have_content(order.reservations.last.checkin)
      expect(page).to have_content(order.reservations.last.checkout)
      expect(page).not_to have_content(order.reservations.first.checkin)
      expect(page).not_to have_content(order.reservations.first.checkout)
    end
  end
end
