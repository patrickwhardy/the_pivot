require "rails_helper"

RSpec.feature "User can change quantity of tools in cart" do
  include SpecTestHelper
  scenario "cart has tools already in it" do
    #   As a visitor
    # When I visit "/cart"
    # Then I should see my item with a quantity of 1
    # And when I increase the quantity
    # Then my current page should be '/cart'
    # And that item's quantity should reflect the increase
    # And the subtotal for that item should increase
    # And the total for the cart should match that increase
    # And when I decrease the quantity
    # Then my current page should be '/cart'
    # And that item's quantity should reflect the decrease
    # And the subtotal for that item should decrease
    # And the total for the cart should match that decrease
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
    # expect(page).to have_content "Item removed."
    expect(page).to have_no_content "Tool0"
    expect(page).to have_content "Total: $0"
  end

end
