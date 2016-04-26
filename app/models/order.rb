class Order < ActiveRecord::Base
  has_many :order_tools
  belongs_to :user
  validates :user_id, presence: true

  enum status: ["Completed", "Cancelled", "Ordered", "Paid"]

  def total
    order_tools.reduce(0) do |sum, line_item|
      sum += line_item.subtotal
    end
  end

  def subtotal(tool_id)
    order_tool = OrderTool.find_by(tool_id: tool_id, order_id: self.id)
    tool = Tool.find(tool_id)
    tool.price * order_tool.quantity
  end

end
