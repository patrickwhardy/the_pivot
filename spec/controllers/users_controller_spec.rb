require "rails_helper"

RSpec.describe UsersController do
  before(:each) do
   request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe "GET #new" do
    it "renders the new page" do
      get :new
      expect(response).to render_template(:new)
      expect(response.status).to eq(200)
    end
    it "assigns a new user to user" do
      get :new
      expect(assigns(:user).class).to eq(User)
    end
  end

  describe "GET #show" do
    context "as a logged in user" do
      it "renders the show page" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        get :show, user: user.slug
        expect(response).to render_template(:show)
        expect(response.status).to eq(200)
      end

      it "assigns the user to be the current user" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        get :show, user: user.slug
        expect(assigns(:user)).to eq(user)
      end
    end

    context "as not a logged in user" do
      it "redirects to the root path" do
        user = create(:user)
        get :show, user: user.slug
        expect(response).to redirect_to(root_path)
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST #create" do
    context "with valid user info" do
      it "sets the flash message with a welcome" do
        post :create, user: {
          email:       "email@example.com",
          password:    "password",
          username:    "username",
          first_name:  "first name",
          last_name:   "last name",
          description: "description"
        }
        expect(flash[:success]).to eq("Account created. Welcome to TinyStay, username")
      end

      it "sets the user id in the session" do
        post :create, user: {
          email:       "email@example.com",
          password:    "password",
          username:    "username",
          first_name:  "first name",
          last_name:   "last name",
          description: "description"
        }
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "redirects to the dashboard" do
        post :create, user: {
          email:       "email@example.com",
          password:    "password",
          username:    "username",
          first_name:  "first name",
          last_name:   "last name",
          description: "description"
        }
        expect(response).to redirect_to(dashboard_path(User.last.slug))
      end
    end

    context "with invalid user info" do
      it "sets the flash message with the users errors" do
        post :create, user: {
          username: "username",
        }
        expect(flash[:error]).to eq("Password can't be blank, Email can't be blank, First name can't be blank, Last name can't be blank")
      end

      it "redirects the user to their last page" do
        post :create, user: {
          username: "username",
        }
        expect(response).to redirect_to("where_i_came_from")
      end
    end
  end

  describe "GET #edit" do
    context "as a logged in user accessing their own edit page" do
      it "sets the user based on the path" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        get :edit, slug: user.slug
        expect(assigns(:user)).to eq(user)
      end

      it "renders the edit page" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        get :edit, slug: user.slug
        expect(response).to render_template(:edit)
      end
    end

    context "as a logged in admin" do
      it "assigns the user based on the path" do
        admin = create(:admin)
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(admin)
        get :edit, slug: user.slug
        expect(assigns(:user)).to eq(user)
      end

      it "renders the edit page" do
        admin = create(:admin)
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(admin)
        get :edit, slug: user.slug
        expect(response).to render_template(:edit)
      end
    end

    context "as an unlogged in user" do
      it "assigns the user based on the path" do
        user = create(:user)
        get :edit, slug: user.slug
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the root path" do
        user = create(:user)
        get :edit, slug: user.slug
        expect(response).to redirect_to root_path
      end
    end

    context "as a logged in user trying to access another edit page" do
      it "sets the user based on the path" do
        user_one = create(:user)
        user_two = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user_one)
        get :edit, slug: user_two.slug
        expect(assigns(:user)).to eq(user_two)
      end

      it "redirects to the root path" do
        user_one = create(:user)
        user_two = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user_one)
        get :edit, slug: user_two.slug
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE #destroy" do
    context "as a user deleting his own account" do
      it "assigns the user based on the path" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        delete :destroy, slug: user.slug
        expect(assigns(:user)).to eq(user)
      end

      it "sets the user to deleted" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        delete :destroy, slug: user.slug
        expect(User.last.status).to eq("deleted")
      end

      it "sets the flash notice to account successfully deleted" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        delete :destroy, slug: user.slug
        expect(flash[:notice]).to eq("Account successfully deleted")
      end

      it "redirects back" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        delete :destroy, slug: user.slug
        expect(response).to redirect_to("where_i_came_from")
      end

      it "clears the session" do
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        delete :destroy, slug: user.slug
        expect(session[:user_id]).to eq(nil)
      end
    end

    context "as an admin deleting another user" do
      it "assigns the user based on the path" do
        admin = create(:admin)
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(admin)
        delete :destroy, slug: user.slug
        expect(assigns(:user)).to eq(user)
      end

      it "sets the user to deleted" do
        admin = create(:admin)
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(admin)
        delete :destroy, slug: user.slug
        expect(User.last.status).to eq("deleted")
      end

      it "sets the flash notice to account successfully deleted" do
        admin = create(:admin)
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(admin)
        delete :destroy, slug: user.slug
        expect(flash[:notice]).to eq("Account successfully deleted")
      end

      it "redirects back" do
        admin = create(:admin)
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(admin)
        delete :destroy, slug: user.slug
        expect(response).to redirect_to("where_i_came_from")
      end

      it "clears the session" do
        admin = create(:admin)
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(admin)
        delete :destroy, slug: user.slug
        expect(session[:user_id]).to eq(nil)
      end
    end

    context "as a user trying to delete another user" do
      it "sets the user based on the path" do
        user_one = create(:user)
        user_two = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user_one)
        delete :destroy, slug: user_two.slug
        expect(assigns(:user)).to eq(user_two)
      end

      it "redirects to the root path" do
        user_one = create(:user)
        user_two = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user_one)
        delete :destroy, slug: user_two.slug
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
