require "rails_helper"

RSpec.feature "User has vanity url" do
  context "with valid username" do
    it "shows slugs for user urls" do
      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      home = create(:home, user: user)
      user.slug = user.username.parameterize

      visit dashboard_path(user.slug)
      expect(current_path).to eq "/#{user.slug}/dashboard"

      visit user_home_path(user.slug, home)
      expect(current_path).to eq"/#{user.slug}/homes/#{home.id}"
    end
  end
end

