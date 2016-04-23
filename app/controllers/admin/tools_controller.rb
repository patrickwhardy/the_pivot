class Admin::ToolsController < Admin::BaseController

  def new
    @tool = Tool.new
    @categories = Category.all
  end

end
