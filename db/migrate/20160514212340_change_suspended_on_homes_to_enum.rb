class ChangeSuspendedOnHomesToEnum < ActiveRecord::Migration
  def change
    remove_column :homes, :suspended
    add_column :homes, :status, :integer, default: 0
  end
end
