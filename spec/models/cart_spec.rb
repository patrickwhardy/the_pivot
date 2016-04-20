require "rails_helper"

RSpec.describe Cart, type: :model do
  it "can add a tool" do
    tool = create(:tool)
    cart = Cart.new(nil)

    assert cart.contents.empty?

    cart.add_tool(tool.id)
    assert_equal({ tool.id => 1 }, cart.contents)
  end

  it "can add multiple tools" do
    first = create(:tool)
    second = create(:tool)
    cart = Cart.new(nil)
    cart.add_tool(first.id)
    cart.add_tool(first.id)
    cart.add_tool(second.id)

    assert_equal({ first.id => 2, second.id => 1 }, cart.contents)
  end

  it "can remove a tool from the cart" do
    first = create(:tool)
    second = create(:tool)
    cart = Cart.new({ first.id => 1, second.id => 1 })
    cart.remove(first.id)
    assert_equal({ second.id => 1 }, cart.contents)
  end
end
