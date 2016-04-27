require "rails_helper"

RSpec.feature "Vistor can remove an item from the cart" do
  scenario "visitor clicks the remove button" do
    screwdriver = create(:tool, name: "Screwdriver")
    saw = create(:tool, name: "Saw")

    visit tools_path
    within(".#{saw.name}") do
      click_on "#{saw.name}"
    end
    click_on "Add to Cart"
    within(".#{screwdriver.name}") do
      click_on "#{screwdriver.name}"
    end
    click_on "Add to Cart"
    click_on "Item"

    within(".#{screwdriver.name}") do
      click_on "Remove"
    end
    expect(page).to have_no_content screwdriver.name
    expect(page).to have_content saw.name
    expect(page).to have_content "Total: $#{saw.price}"
  end
end
