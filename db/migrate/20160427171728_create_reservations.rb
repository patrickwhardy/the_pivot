class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :tool, index: true, foreign_key: true
      t.references :date_reserved, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
