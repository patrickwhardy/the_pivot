class OrderTool < ActiveRecord::Base
  belongs_to :tool  
  belongs_to :order

  def subtotal
    quantity * tool.price
  end

end
