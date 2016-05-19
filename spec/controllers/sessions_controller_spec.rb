require "rails_helper"

RSpec.describe SessionsController do
  describe "GET #new" do
    it "assigns a new user to user" do
      post :new
      expect(assigns(:user).class).to eq(User)
    end

    it "renders the new template" do
      post :new
      expect(response).to render_template(:new)
    end
  end

  describe "DELETE #destroy" do
    it "clears the session" do
      delete :destroy
      expect(session[:user_id]).to eq(nil)
    end

    it "redirects to the root path" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "assigns user based on params" do
        user = create(:user)
        post :create, session: {
          username: user.username,
          password: "password"
        }
        expect(assigns(:user)).to eq(user)
      end

      it "sets the session id to the user" do
        user = create(:user)
        post :create, session: {
          username: user.username,
          password: "password"
        }
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets the flash message success" do
        user = create(:user)
        post :create, session: {
          username: user.username,
          password: "password"
        }
        expect(flash[:success]).to eq("Login successful. Welcome to Tiny Stay, #{user.username.capitalize}")
      end

      it "redirects to the user_dashboard" do
        user = create(:user)
        post :create, session: {
          username: user.username,
          password: "password"
        }
        expect(response).to redirect_to(dashboard_path(user.slug))
      end
    end

    context "with invalid user params" do
      it "assigns the current user based on username" do
        user = create(:user)
        post :create, session: {
          username: user.username
        }
        expect(assigns(:user)).to eq(user)
      end

      it "sets the flash error message" do
        user = create(:user)
        post :create, session: {
          username: user.username
        }
        expect(flash[:error]).to eq("Invalid email/password combination")
      end

      it "redirects to the login path" do
        user = create(:user)
        post :create, session: {
          username: user.username
        }
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
