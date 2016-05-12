class AddOrderIdToReservations < ActiveRecord::Migration
  def change
    add_reference :reservations, :order, index: true, foreign_key: true
  end
end
