require "rails_helper"

RSpec.describe OrderCreator, type: :model do
  it "will not save an order tool without a valid user id" do
    tool = create(:tool)
    creator = OrderCreator.new({cart: { tool.id => 2 } })

    assert_equal false, creator.save
  end
end
