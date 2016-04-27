require "rails_helper"

RSpec.feature "User can change quantity of tools in cart" do
  include SpecTestHelper
  scenario "cart has tools already in it" do

    add_tools_to_cart(1)
    first_quantity = 3
    second_quantity = 2
    visit cart_path

    fill_in "cart_tool[quantity]", with: "#{first_quantity}"
    click_on "Update"

    assert_equal cart_path, current_path
    expect(page).to have_field("cart_tool[quantity]", with: "3")
    expect(page).to have_content("Subtotal: $#{first_quantity * @tools[0].price}")
    expect(page).to have_content "Total: $#{first_quantity * @tools[0].price}"

    fill_in "cart_tool[quantity]", with: "#{second_quantity}"
    click_on "Update"

    assert_equal cart_path, current_path
    expect(page).to have_field("cart_tool[quantity]", with: "2")
    expect(page).to have_content("Subtotal: $#{second_quantity * @tools[0].price}")
    expect(page).to have_content "Total: $#{second_quantity * @tools[0].price}"
  end

  scenario "user tries to remove same as in cart" do
    add_tools_to_cart(1)
    first_quantity = 0
    visit cart_path
    fill_in "cart_tool[quantity]", with: "#{first_quantity}"
    click_on "Update"
    expect(page).to have_no_content "Tool0"
    expect(page).to have_content "Total: $0"
  end

end
