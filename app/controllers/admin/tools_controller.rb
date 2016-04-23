class Admin::ToolsController < Admin::BaseController

  def new
    @tool = Tool.new
    @categories = Category.all
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      flash[:success] = "Tool Created"
      redirect_to tools_path(@tool.id)
    else
      flash.now[:warning] = "Tool Not Created"
      render :new
    end
  end

  private
  def tool_params
    params.require(:tool).permit(:name, :description, :price, :image_path, :category_id)
  end
end
