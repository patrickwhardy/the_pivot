class AddColumnToTools < ActiveRecord::Migration
  def change
    add_column :tools, :inventory, :integer
  end
end
