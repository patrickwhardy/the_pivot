require "rails_helper"

RSpec.feature "Vistor can add tools to cart" do
  scenario "visitor adds tool to cart from tool page" do

    drill = create(:tool, name: "Drill")
    chainsaw = create(:tool, name: "Chainsaw")

    visit tools_path

    within(".#{drill.name}") do
        click_on "Add to Cart"
    end

    click_on "View Cart"

    assert_equal "/cart", current_path
    expect(page).to have_content drill.name
    expect(page).to have_content drill.description
    expect(page).to have_content drill.price
    expect(page).to have_css("img[src*='#{drill.image_path}']")
    expect(page).to have_content "Total #{drill.price}"

  end

    scenario "visitor adds multiple tools to cart and views cart total" do
        # And there should be a "total" price for the cart that should be the sum of all items in the cart
    end

end
