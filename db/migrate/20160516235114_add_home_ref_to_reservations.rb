class AddHomeRefToReservations < ActiveRecord::Migration
  def change
    remove_reference :reservations, :home, index: true
    add_reference :reservations, :home, index: true, foreign_key: true
  end
end
