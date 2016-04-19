class AddCategoryToTools < ActiveRecord::Migration
  def change
    add_reference :tools, :category, index: true, foreign_key: true
  end
end
