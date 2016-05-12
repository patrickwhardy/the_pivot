class UpdateReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :tool_id
    remove_column :reservations, :date_reserved_id
    remove_column :reservations, :user_id

    add_reference :reservations, :home, index: true
    add_column :reservations, :checkin, :date
    add_column :reservations, :checkout, :date
  end
end
