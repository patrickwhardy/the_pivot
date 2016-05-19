require "rails_helper"

RSpec.describe CartsController do

  before(:each) do
   request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe "POST #create" do
    context "with no dates" do
      it "sets the flash error" do
        home = create(:home)
        post :create,
          user: home.user.id,
          id: home.id,
          date: {
            checkin_date: "",
            checkout_date: ""
        }
        expect(flash[:error]).to eq("You must have a checkin and checkout date")
      end
    end
    context "with checkin later than checkout" do
      it "sets the flash error" do
        home = create(:home)
        post :create,
          user: home.user.id,
          id: home.id,
          date: {
            checkin_date: "05/03/2018",
            checkout_date: "05/02/2018"
        }
        expect(flash[:error]).to eq("You must select a checkin date before your checkout date")
      end
    end

    context "with valid dates" do
      it "sets the flash success" do
        home = create(:home)
        post :create,
          user: home.user.id,
          id: home.id,
          date: {
            checkin_date: "05/02/2018",
            checkout_date: "05/03/2018"
        }
        expect(flash[:success]).to eq("You've added this reservation to your cart")
      end

      it "assigns the session cart to the item added to the cart" do
        home = create(:home)
        post :create,
          user: home.user.id,
          id: home.id,
          date: {
            checkin_date: "05/02/2018",
            checkout_date: "05/03/2018"
        }
        expect(session[:cart]).to eq([{"home"=>"9", "checkin"=>"05/02/2018", "checkout"=>"05/03/2018"}])
      end
    end

    context "with reserved dates" do
      it "sets the flash error" do
        home = create(:home)
        ReservationParser.any_instance.stubs(:is_valid?).returns(false)
        ReservationParser.any_instance.stubs(:reserved_dates).returns([])
        post :create,
          user: home.user.id,
          id: home.id,
          date: {
            checkin_date: "05/02/2018",
            checkout_date: "05/03/2018"
        }
        expect(flash[:error]).to eq("This home is already reserved on ")
      end
    end

    context "with any dates" do
      it "redirects to referrer" do
        home = create(:home)
        post :create,
          user: home.user.id,
          id: home.id,
          date: {
            checkin_date: "05/02/2018",
            checkout_date: "05/03/2018"
        }

        expect(response).to redirect_to(request.referrer)
      end

      it "clears the session[:checkin]" do
        home = create(:home)
        post :create,
          user: home.user.id,
          id: home.id,
          date: {
            checkin_date: "05/02/2018",
            checkout_date: "05/03/2018"
        }
        expect(session[:checkin]).to eq(nil)
      end

      it "clears the session[:checkout]" do
        home = create(:home)
        post :create,
          user: home.user.id,
          id: home.id,
          date: {
            checkin_date: "05/02/2018",
            checkout_date: "05/03/2018"
        }
        expect(session[:checkout]).to eq(nil)
      end
    end
  end

  describe "DELETE #destroy" do
    it "redirects to the cart" do
      delete :destroy

      expect(response).to redirect_to(cart_path)
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      get :show

      expect(response).to render_template(:show)
    end
  end
end
