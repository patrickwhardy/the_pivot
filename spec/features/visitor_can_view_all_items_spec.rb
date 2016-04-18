require 'rails_helper'

RSpec.feature "Vistor can view all items" do
  scenario "visitor opens the '/items' path" do
    hammer = create(:tool)
    screwdriver = create(:tool, name: "Screwdriver")
    saw = create(:tool, name: "Saw")

    visit tools_path

    expect(page).to have_content "Hammer"
    expect(page).to have_content "Screwdriver"
    expect(page).to have_content "Saw"

    expect(page).to have_content "Forsooth tis Juliet!"

  end
end
