require "rails_helper"

RSpec.feature "search by zip" do
  it "lets user search from search page" do
    num_filler = 10
    num_relevant = 3
    num_filler.times do |n|
      create(:home, name: "filler home #{n}")
    end

    num_relevant.times do |n|
      create(:home, name: "relevant home #{n}", description: "asdf 80212 asdf")
    end

    visit search_path
    page.fill_in "home_description", with: "80212"
    click_on "Search"

    expect(page).to have_content("relevant home 0")
    expect(page).to have_content("relevant home 1")
    expect(page).to have_content("relevant home 2")
    expect(page).to have_no_content("filler")
  end
end
