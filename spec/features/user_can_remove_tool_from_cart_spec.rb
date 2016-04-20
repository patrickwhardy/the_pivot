require "rails_helper"

RSpec.feature "Vistor can remove an item from the cart" do
  include SpecTestHelper
  scenario "visitor clicks the remove button" do
    add_tools_to_cart(2)
    visit cart_path

    within(".Tool1") do
      click_on "Remove"
    end
    expect(page).to have_no_content "Tool1"
    expect(page).to have_content "Tool0"
    expect(page).to have_content "Total: #{@tools[0].price}"
  end
end
