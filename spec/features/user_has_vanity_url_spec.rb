require "rails_helper"

RSpec.feature "User has vanity url" do
  context "with valid username" do
    it "shows slugs for user urls" do
      user = create(:user)
      home = create(:home, user: user)
      slug = user.slug

      visit user_dashboard_path(user)
      current_path.should == "/#{slug}/dashboard"

      visit user_home(user)
      current_path.should == "/#{slug}/homes/#{home.id}"
    end
  end
end

