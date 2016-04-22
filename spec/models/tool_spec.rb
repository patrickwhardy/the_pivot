require 'rails_helper'

RSpec.describe Tool, type: :model do

  it "out of stock returns true if and only if inventory 0" do
    tool1 = create(:tool, inventory: 0)
    tool2 = create(:tool, inventory: 3)

    assert_equal true, tool1.out_of_stock?
    assert_equal false, tool2.out_of_stock?
  end

end
