require "rails_helper"

RSpec.describe OrdersController do
  describe "POST create" do
    context "with a valid order" do
      it "sets the flash success" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        OrderCreator.any_instance.stubs(:save).returns(true)
        post :create
        expect(flash[:success]).to eq("Order was successfully placed.")
      end

      it "sets the cart session to be an empty cart" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        OrderCreator.any_instance.stubs(:save).returns(true)
        post :create
        expect(session[:cart]).to eq([])
      end

      it "redirects to the users dashboard path" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        OrderCreator.any_instance.stubs(:save).returns(true)
        post :create
        expect(response).to redirect_to(dashboard_path(user.slug))
      end
    end

    context "with an invalid order" do
      it "sets the flash error message" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        OrderCreator.any_instance.stubs(:save).returns(false)
        post :create
        expect(flash[:error]).to eq("Something went wrong. Please try again.")
      end

      it "redirects to the cart path" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        OrderCreator.any_instance.stubs(:save).returns(false)
        post :create
        expect(response).to redirect_to(cart_path)
      end
    end
  end
end
