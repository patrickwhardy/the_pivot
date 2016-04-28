require "rails_helper"

RSpec.feature "Vistor can add tools to cart" do
  include SpecTestHelper

  scenario "visitor adds tool to cart from tool page" do
    add_tools_to_cart(1)
    drill = Tool.first
    click_on "Item"

    assert_equal "/cart", current_path
    expect(page).to have_content drill.name
    expect(page).to have_content drill.description
    expect(page).to have_content drill.price
    expect(page).to have_css("img[src*='#{drill.image_path}']")
    expect(page).to have_content "Total: $#{drill.price}"
  end

  scenario "visitor adds multiple tools to cart and views cart total" do
    add_tools_to_cart(2)
    total_price = Tool.first.price + Tool.last.price
    click_on "Item"

    expect(page).to have_content "Total: $#{total_price}"
  end
end
