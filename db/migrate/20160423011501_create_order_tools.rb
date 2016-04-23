class CreateOrderTools < ActiveRecord::Migration
  def change
    create_table :order_tools do |t|
      t.references :tool, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
