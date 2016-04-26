class Order < ActiveRecord::Base
  has_many :order_tools

  enum status: ["Completed", "Cancelled", "Ordered", "Paid"]

  def total
    order_tools.reduce(0) do |sum, line_item|
      sum += line_item.subtotal
    end
  end

end
