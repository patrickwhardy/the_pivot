class AddLatitudeAndLongitudeToHomes < ActiveRecord::Migration
  def change
    add_column :homes, :latitude, :float
    add_column :homes, :longitude, :float
  end
end
