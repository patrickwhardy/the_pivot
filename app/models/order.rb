class Order < ActiveRecord::Base
  has_many :order_tools


  enum status: ["completed", "cancelled", "ordered", "paid"]
end
