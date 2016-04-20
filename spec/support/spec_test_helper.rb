module SpecTestHelper
  # def set_cart(tool_id, quantity)
  #   if request.session[:cart].nil?
  #     request.session[:cart] = { tool_id => quantity }
  #   else
  #     request.session[:cart].merge!({ tool_id => quantity })
  #   end
  # end

  def add_tools_to_cart(num)
    @tools = []
    num.times do |n|
      @tools << create(:tool, name: "Tool#{n}")
    end

    visit tools_path

    num.times do |n|
      tool = @tools[n-1]
      within(".#{tool.name}") do
        click_on "Add to Cart"
      end
    end
  end

  def create_user_account(num=1)

  end

  def create_admin_account(num=1)
  end
end
