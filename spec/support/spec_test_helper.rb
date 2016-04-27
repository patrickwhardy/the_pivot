module SpecTestHelper
  def add_tools_to_cart(num)
    @tools = []
    num.times do |n|
      @tools << create(:tool, name: "Tool#{n}")
    end

    visit tools_path

    num.times do |n|
      tool = @tools[n-1]
      within(".#{tool.name}") do
        click_on "#{tool.name}"
      end
      click_on "Add to Cart"
    end
  end

  def login_user(user)
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    within ".login" do
      click_on "Login"
    end
  end
end
