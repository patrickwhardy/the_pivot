# require "rails_helper"
#
# RSpec.feature "search by zip" do
#   it "lets user search from search page", geocode: true do
#     num_filler = 10
#     num_relevant = 3
#     num_filler.times do |n|
#       create(:home, name: "filler home #{n}", address: "16785 Wood Song Ct Riverside CA 92504")
#     end
#
#     num_relevant.times do |n|
#       create(:home, name: "relevant home #{n}", address: "8801 W Belleview Ave Littleton CO, 80123")
#     end
#
#     visit homes_path
#     within ".navbar" do
#       page.fill_in "location", with: ""
#       click_on "Search"
#     end
#
#     expect(current_path).to eq(homes_path)
#
#     expect(page).to have_content("relevant home 0")
#     expect(page).to have_content("relevant home 1")
#     expect(page).to have_content("relevant home 2")
#     expect(page).to have_no_content("filler")
#   end
# end
