require 'rails_helper'

RSpec.feature "Vistor can view all items" do
  scenario "visitor opens the '/items' path" do
    hammer = create(:tool)
    screwdriver = create(:tool, name: "Screwdriver")
    saw = create(:tool, name: "Saw")

    visit tools_path

    expect(page).to have_content hammer.name
    expect(page).to have_content screwdriver.name
    expect(page).to have_content saw.name

    expect(page).to have_css("img[src*='#{hammer.image_path}']")
    expect(page).to have_content hammer.description
    expect(page).to have_content hammer.price

  end
end
