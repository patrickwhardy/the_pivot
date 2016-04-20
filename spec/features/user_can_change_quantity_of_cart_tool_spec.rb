require "rails_helper"

RSpec.feature "User can change quantity of tools in cart" do
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
    tool = create(:tool)
    cart = Cart.new({ tool.id => 1 })
    first_quantity = 3
    second_quantity = 2

    visit cart_path
    fill_in "Quantity", with: "#{first_quantity}"
    click_on "Update Quantity"

    assert_equal cart_path, current_path
    within(".#{tool.name}") do
      it { should have_field("Quantity", :with => "3") }
      should have_content("Subtotal: #{first_quantity * tool.price}")
    end
    expect(page).to have_content "Total: #{first_quantity * tool.price}"

    fill_in "Quantity", with: "#{second_quantity}"
    click_on "Update Quantity"

    assert_equal cart_path, current_path
    within(".#{tool.name}") do
      it { should have_field("Quantity", :with => "3") }
      should have_content("Subtotal: #{second_quantity * tool.price}")
    end
    expect(page).to have_content "Total: #{second_quantity * tool.price}"
  end
end
