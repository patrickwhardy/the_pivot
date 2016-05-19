require "rails_helper"

RSpec.describe User::HomesController do

  before(:each) do
   request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe "GET #new" do
    it "assigns a new home to home" do
      user = create(:user)
      get :new, path: user.slug
      expect(assigns(:home).class).to eq(Home)
    end

    it "renders the new template" do
      user = create(:user)
      get :new, path: user.slug
      expect(response).to render_template(:new)
    end
  end

  describe "GET #index" do
    it "finds the user by slug and assigns it to user" do
      user = create(:user)
      get :index, path: user.slug
      expect(assigns(:user)).to eq(user)
    end

    it "renders the index template" do
      user = create(:user)
      get :index, path: user.slug
      expect(response).to render_template(:index)
    end
  end

  describe "GET #edit" do
    it "finds the user by slug and assigns it to user" do
      home = create(:home)
      user = create(:user)
      get :edit, path: user.slug, id: home.id
      expect(assigns(:user)).to eq(user)
    end

    context "as current user trying to edit own home" do
      context "it finds the user by slug" do
        it "assigns the home based on home id in params" do
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(user)
          get :edit, path: user.slug, id: home.id
          expect(assigns(:home)).to eq(home)
        end

        context "it doesnt find the home by the id in params" do
          it "redirects to root path" do
            home = create(:home)
            user = home.user
            ApplicationController.any_instance.stubs(:current_user).returns(user)
            get :edit, path: user.slug, id: 100
            expect(response).to redirect_to(root_path)
          end
        end

        it "renders the edit template" do
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(user)
          get :edit, path: user.slug, id: home.id
          expect(response).to render_template(:edit)
        end
      end

      context "it doesnt find the user by slug" do
        it "redirects to root path" do
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(user)
          get :edit, path: 100, id: home.id
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "as admin trying to edit home" do
      context "it finds the user by slug" do
        it "assigns the home based on home id in params" do
          admin = create(:admin)
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(admin)
          get :edit, path: user.slug, id: home.id
          expect(assigns(:home)).to eq(home)
        end

        context "it doesnt find the home by the id in params" do
          it "redirects to root path" do
            admin = create(:admin)
            home = create(:home)
            user = home.user
            ApplicationController.any_instance.stubs(:current_user).returns(admin)
            get :edit, path: user.slug, id: 100
            expect(response).to redirect_to(root_path)
          end
        end

        it "renders the edit template" do
          admin = create(:admin)
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(admin)
          get :edit, path: user.slug, id: home.id
          expect(response).to render_template(:edit)
        end
      end

      context "it doesnt find the user by slug" do
        it "redirects to root path" do
          admin = create(:admin)
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(admin)
          get :edit, path: 100, id: home.id
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe "PATCH #update" do
    it "assigns the user based on the id" do
      home = create(:home)
      user = home.user
      patch :update, path: user.id, id: home.id, home: home.attributes
      expect(assigns(:user)).to eq(user)
    end

    context "as user trying to edit another users home" do
      it "redirects to root path" do
        home = create(:home)
        user = home.user
        patch :update, path: user.id, id: home.id, home: home.attributes
        expect(response).to redirect_to(root_path)
      end
    end

    context "as user trying to edit own home" do
      it "assigns the home based on user homes and id" do
        home = create(:home)
        user = home.user
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        patch :update, path: user.id, id: home.id, home: home.attributes
        expect(assigns(:home)).to eq(home)
      end

      context "it doesnt find a home" do
        it "redirects to the root path" do
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(user)
          patch :update, path: user.id, id: 100, home: home.attributes
          expect(response).to redirect_to(root_path)
        end
      end

      context "it finds the home" do
        it "updates the home based on given attributes" do
          home = create(:home)
          user = home.user
          home.name = "new name"
          ApplicationController.any_instance.stubs(:current_user).returns(user)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(assigns(:home).name).to eq("new name")
        end
      end

      context "the home successfully saves" do
        it "sets the flash success" do
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(user)
          Home.any_instance.stubs(:save).returns(true)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(flash[:notice]).to eq("Home successfully updated")
        end

        it "redirects to the user home path" do
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(user)
          Home.any_instance.stubs(:save).returns(true)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(response).to redirect_to(user_home_path(user.slug, home))
        end
      end

      context "the home doesnt save" do
        it "sets the flash error message" do
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(user)
          Home.any_instance.stubs(:save).returns(false)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(flash[:error]).to eq("")
        end

        it "renders the edit template" do
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(user)
          Home.any_instance.stubs(:save).returns(false)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(response).to render_template(:edit)
        end
      end
    end

    context "as an admin trying to edit a users home" do
      it "assigns the home based on user homes and id" do
        admin = create(:admin)
        home = create(:home)
        user = home.user
        ApplicationController.any_instance.stubs(:current_user).returns(admin)
        patch :update, path: user.id, id: home.id, home: home.attributes
        expect(assigns(:home)).to eq(home)
      end

      context "it doesnt find a home" do
        it "redirects to the root path" do
          admin = create(:admin)
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(admin)
          patch :update, path: user.id, id: 100, home: home.attributes
          expect(response).to redirect_to(root_path)
        end
      end

      context "it finds the home" do
        it "updates the home based on given attributes" do
          admin = create(:admin)
          home = create(:home)
          user = home.user
          home.name = "new name"
          ApplicationController.any_instance.stubs(:current_user).returns(admin)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(assigns(:home).name).to eq("new name")
        end
      end

      context "the home successfully saves" do
        it "sets the flash success" do
          admin = create(:admin)
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(admin)
          Home.any_instance.stubs(:save).returns(true)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(flash[:notice]).to eq("Home successfully updated")
        end

        it "redirects to the user home path" do
          admin = create(:admin)
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(admin)
          Home.any_instance.stubs(:save).returns(true)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(response).to redirect_to(user_home_path(user.slug, home))
        end
      end

      context "the home doesnt save" do
        it "sets the flash error message" do
          admin = create(:admin)
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(admin)
          Home.any_instance.stubs(:save).returns(false)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(flash[:error]).to eq("")
        end

        it "renders the edit template" do
          admin = create(:admin)
          home = create(:home)
          user = home.user
          ApplicationController.any_instance.stubs(:current_user).returns(admin)
          Home.any_instance.stubs(:save).returns(false)
          patch :update, path: user.id, id: home.id, home: home.attributes
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe "POST #create" do
    it "assigns current user to be the user" do
      home = create(:home)
      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      post :create, path: user.id, home: home.attributes
      expect(assigns(:user)).to eq(user)
    end

    it "assigns the home to be a new user home based on home params" do
      home = create(:home)
      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      post :create, path: user.id, home: home.attributes
      expect(assigns(:home).class).to eq(Home)
    end

    context "the new home doesnt save" do
      it "sets the flash error" do
        home = create(:home)
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        Home.any_instance.stubs(:save).returns(false)
        post :create, path: user.id, home: home.attributes
        expect(flash[:error]).to eq("")
      end

      it "redirects to the referrer" do
        home = create(:home)
        user = create(:user)
        ApplicationController.any_instance.stubs(:current_user).returns(user)
        Home.any_instance.stubs(:save).returns(false)
        post :create, path: user.id, home: home.attributes
        expect(response).to redirect_to("where_i_came_from")
      end
    end
  end

  describe "GET #show" do
    it "assigns the user based on the slug" do
      home = create(:home)
      user = home.user

      get :show, path: user.slug, id: home.id
      expect(assigns(:user)).to eq(user)
    end

    context "it cant find a user" do
      it "redirects to the root path" do
        home = create(:home)
        user = home.user

        get :show, path: user.id, id: home.id
        expect(response).to redirect_to(root_path)
      end
    end

    context "it finds a user" do
      it "sets the home to the home it finds" do
        home = create(:home)
        user = home.user

        get :show, path: user.slug, id: home.id
        expect(assigns(:home)).to eq(home)
      end

      it "renders the show template" do
        home = create(:home)
        user = home.user

        get :show, path: user.slug, id: home.id
        expect(response).to render_template(:show)
      end
    end
  end

  describe "GET #index" do
    it "assigns the user based on the path" do
      user = create(:user)

      get :index, path: user.slug
      expect(assigns(:user)).to eq(user)
    end

    it "renders the index template" do
      user = create(:user)

      get :index, path: user.slug
      expect(response).to render_template(:index)
    end
  end

  describe "DELETE #destroy" do
    it "suspends the home given in the path" do
      home = create(:home)
      user = home.user
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      delete :destroy, path: user.slug, id: home.id
      expect(Home.last.suspended?).to be(true)
    end

    it "sets the flash warning" do
      home = create(:home)
      user = home.user
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      delete :destroy, path: user.slug, id: home.id
      expect(flash[:warning]).to eq("#{home.name} has been suspended")
    end

    it "redirects to the admin homes path" do
      home = create(:home)
      user = home.user
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      delete :destroy, path: user.slug, id: home.id
      expect(response).to redirect_to(admin_homes_path)
    end
  end
end
