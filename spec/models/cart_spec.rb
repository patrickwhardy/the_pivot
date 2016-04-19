require "rails_helper"

RSpec.describe Cart, type: :model do
  it "can add tools" do
    tool = create(:tool)
    cart = Cart.new(nil)

    assert cart.contents.empty?

    cart.add_tool(tool.id)
    assert_equal( {tool.id => 1}, cart.contents )
  end
end
