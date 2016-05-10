class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :name
      t.string :description
      t.decimal :price_per_night
      t.string :address
      t.references :user
      t.timestamps null: false
    end
  end
end
