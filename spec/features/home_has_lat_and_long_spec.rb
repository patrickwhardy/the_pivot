require "rails_helper"

RSpec.feature "Home has lat and long" do
  scenario "home knows its own lat and long" do
    home = create(:home, address: "108 West 41st street, Austin, TX 78751")

    expect(home.latitude).to eq ""
    expect(home.longitude).to eq ""
  end

  scenario "homes can be found close to other homes" do
  end

end
