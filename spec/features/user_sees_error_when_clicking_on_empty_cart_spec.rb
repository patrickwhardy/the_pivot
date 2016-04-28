require "rails_helper"

RSpec.feature "User with no items in cart" do
  scenario "tries to see cart page" do
    visit root_path
    assert_equal 0, Tool.count

    click_on "Item"

    assert_equal root_path, current_path
    expect(page).to have_content "Start shopping before viewing your cart!"

    visit cart_path

    assert_equal root_path, current_path
    expect(page).to have_content "Start shopping before viewing your cart!"
  end
end
