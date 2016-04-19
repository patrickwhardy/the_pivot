class CategoriesController < ApplicationController
  def view
    @category = Category.find_by(name: params[:category_name])
    @tools = @category.tools
  end
end
