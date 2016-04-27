class CreateDateReserveds < ActiveRecord::Migration
  def change
    create_table :date_reserveds do |t|
      t.date :date_reserved

      t.timestamps null: false
    end
  end
end
