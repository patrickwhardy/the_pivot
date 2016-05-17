require "rails_helper"

RSpec.feature "Home has lat and long" do

  before :all do
    @home = create(:home, address: "108 West 41st street, Austin, TX 78751")    
  end
  
  scenario "home knows its own lat and long" do
    # these lats and longs are being stubbed in geocode config
    expect(@home.latitude).to eq 40.7143528
    expect(@home.longitude).to eq -74.0059731
  end

end
