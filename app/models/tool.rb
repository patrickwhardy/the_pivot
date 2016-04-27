class Tool < ActiveRecord::Base
  has_many :reservations

  def out_of_stock?
    inventory <= 0 if inventory
  end

end
