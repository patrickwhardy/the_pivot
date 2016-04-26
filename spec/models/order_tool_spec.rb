require 'rails_helper'

RSpec.describe OrderTool, type: :model do
  it "will not save without an order id" do
    tool = create(:tool)
    quantity = 2
    order_tool = OrderTool.new(tool_id: tool.id, quantity: quantity)

    refute order_tool.save
  end
end
