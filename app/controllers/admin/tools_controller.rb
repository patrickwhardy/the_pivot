class Admin::ToolsController < Admin::BaseController

  def new
    @tool = Tool.new
    @categories = Category.all
  end

  def create
    @tool = Tool.new(tool_params)
    PhotoAssigner.call(@tool)
    if @tool.save
      flash[:success] = "Tool Created"
      redirect_to tool_path(@tool.id)
    else
      flash.now[:warning] = "Tool Not Created"
      render :new
    end
  end

  def index
    @tools = Tool.all
  end

  def edit
    @tool = Tool.find(params[:id])
    @categories = Category.all
  end

  def update
    @tool = Tool.find(params[:id])
    @tool.update(tool_params)
    if @tool.save
      flash[:success] = "Tool Updated"
      redirect_to tool_path(@tool)
    else
      flash.now[:warning] = "Tool Not Updated"
      render :edit
    end
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :price, :image_path, :category_id)
  end
end
