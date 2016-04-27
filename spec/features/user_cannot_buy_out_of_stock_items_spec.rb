require "rails_helper"

RSpec.feature "Vistor cannot buy out of stock items" do
  scenario "visitor sees out of stock tools marked out of stock" do
    saw = create(:tool, name: "Saw", inventory: 0)

    visit tools_path
    within(".#{saw.name}") do
      expect(page).to have_content "Out of Stock"
      expect(page).to have_no_content "Add to Cart"
    end
    click_on "#{saw.name}"
    expect(page).to have_content "Out of Stock"
    expect(page).to have_no_content "Add to Cart"
  end
end
