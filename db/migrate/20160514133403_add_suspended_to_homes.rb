class AddSuspendedToHomes < ActiveRecord::Migration
  def change
    add_column :homes, :suspended, :boolean, default: false
  end
end
