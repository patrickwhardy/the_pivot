class OrderTool < ActiveRecord::Base
  belongs_to :tool
  belongs_to :order
end
