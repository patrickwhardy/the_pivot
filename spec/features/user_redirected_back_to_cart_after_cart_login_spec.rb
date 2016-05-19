require "rails_helper"

RSpec.feature "user redirected back to cart" do
  scenario "user logs from cart checkout page" do
    user = create(:user)
    home = create(:home)
    cart_contents = {"home" => home.id, "checkin" => Date.parse("2016-07-01"), "checkout" => Date.parse("2016-07-22")}
    visit user_home_path(home.user.slug, home)

    fill_in "date_checkin_date", with: "05/02/2017"
    fill_in "date_checkout_date", with: "05/06/2017"

    click_on("Add to Cart")
    click_on("1 Reservation - $400.00")
    within (".login-btn") do
      click_link("Login")
    end

    fill_in "Password", with: "#{user.password}"
    fill_in "Username", with: "#{user.username}"
    click_button "Login"

    expect(current_path).to eq(cart_path)
  end
end
