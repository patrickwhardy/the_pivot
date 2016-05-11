class AddHomeToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :home, index: true, foreign_key: true
  end
end
