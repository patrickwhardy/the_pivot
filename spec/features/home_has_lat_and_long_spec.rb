require "rails_helper"

RSpec.feature "Home has lat and long" do

  before :all do
    @home = create(:home, address: "108 West 41st street, Austin, TX 78751")    
  end
  
  scenario "home knows its own lat and long" do
    expect(@home.latitude).to eq 30.304665
    expect(@home.longitude).to eq -97.731714
  end

end
