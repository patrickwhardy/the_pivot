class Tool < ActiveRecord::Base

  def out_of_stock?
    inventory <= 0 if inventory
  end

end
