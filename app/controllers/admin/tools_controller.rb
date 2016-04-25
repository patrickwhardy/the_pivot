class Admin::ToolsController < Admin::BaseController

  def new
    @tool = Tool.new
    @categories = Category.all
  end

  def create
    @tool = Tool.new(tool_params)

    ###############################################################

    ### the fotofetcher gem is present for development purposes
    ### though it could be left in to provide default images in production,
    ### it's probably not cool to go jacking people's images/bandwidth

    @fetcher = Fotofetch::Fetch.new
    url = @fetcher.fetch_links(tool_params[:name]).values.first
    @tool.image_path = url if @tool.image_path.empty?

    ###############################################################


    if @tool.save
      flash[:success] = "Tool Created"
      redirect_to tool_path(@tool.id)
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
