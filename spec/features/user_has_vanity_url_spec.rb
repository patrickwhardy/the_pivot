require "rails_helper"

RSpec.feature "User has vanity url" do
  context "with valid username" do
    it "shows slugs for user urls" do
      home = create(:home)
      user = home.user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit dashboard_path(user.slug)
      expect(current_path).to eq "/#{user.slug}/dashboard"

      visit user_home_path(user.slug, home)
      expect(current_path).to eq"/#{user.slug}/homes/#{home.id}"
    end

    it "returns 404 without slug in path" do
      home = create(:home)
      user = home.user
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit "/ghghg/homes/#{home.id}"
      expect(current_path).to eq(root_path)
    end
  end
end
