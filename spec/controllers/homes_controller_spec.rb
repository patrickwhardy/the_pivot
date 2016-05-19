require "rails_helper"

RSpec.describe HomesController do
  describe "GET #index" do
    it "sets the session checkin" do
      get :index, checkin: "01/01/1999"
      expect(session[:checkin]).to eq("01/01/1999")
    end

    it "sets the session checkout" do
      get :index, checkout: "01/01/1999"
      expect(session[:checkout]).to eq("01/01/1999")
    end

    context "with location, checkin, and checkout" do
      it "renders index" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "with checkin and checkout present" do
      it "renders index" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "with location present" do
      it "renders index" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "with no params" do
      it "renders index" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET #search" do
    it "assigns a new home to home" do
      get :search
      expect(assigns(:home).class).to eq(Home)
    end

    it "renders the search page" do
      get :search
      expect(response).to render_template(:search)
    end
  end
end
