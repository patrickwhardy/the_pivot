require "rails_helper"

RSpec.feature "Vistor can view tools by category" do
  scenario "visitor sees '/:category_name' path tools in that category" do
    power_tools = create(:category, name: "power_tools")
    screwdrivers = create(:category, name: "screwdrivers")

    drill = create(:tool, name: "Drill", category_id: power_tools.id)
    chainsaw = create(:tool, name: "Chainsaw", category_id: power_tools.id)
    phillips = create(:tool, name: "Phillips", category_id: screwdrivers.id)

    visit "/#{power_tools.name}"

    expect(page).to have_content drill.name
    expect(page).to have_content chainsaw.name
    expect(page).to have_no_content phillips.name
  end
end
