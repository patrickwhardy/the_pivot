require "rails_helper"

RSpec.describe Cart, type: :model do
  it "can add a tool" do
    tool = create(:tool)
    cart = Cart.new(nil)

    assert cart.contents.empty?

    cart.add_tool(tool.id)
    assert_equal({ tool.id.to_s => 1 }, cart.contents)
  end

  it "can add multiple tools" do
    first = create(:tool)
    second = create(:tool)
    cart = Cart.new(nil)
    cart.add_tool(first.id.to_s)
    cart.add_tool(first.id.to_s)
    cart.add_tool(second.id.to_s)

    assert_equal({ first.id.to_s => 2, second.id.to_s => 1 }, cart.contents)
  end

  it "can remove a tool from the cart" do
    first = create(:tool)
    second = create(:tool)
    cart = Cart.new({ first.id.to_s => 1, second.id.to_s => 1 })
    cart.remove(first.id.to_s)
    assert_equal({ second.id.to_s => 1 }, cart.contents)
  end
end
