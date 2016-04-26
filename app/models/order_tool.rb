class OrderTool < ActiveRecord::Base
  belongs_to :tool
  belongs_to :order
  validates :order_id, presence: true

  def subtotal
    quantity * tool.price
  end

end
