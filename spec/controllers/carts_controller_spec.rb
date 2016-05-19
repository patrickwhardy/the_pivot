# require "rails_helper"
#
# RSpec.describe CartsController do
#   describe "POST #create" do
#     context "with checkin later than checkout" do
#       it "sets the flash error" do
#         post :create
#       end
#     end
#
#     context "with valid dates" do
#       it "sets the flash success" do
#
#       end
#     end
#
#     context "with reserved dates" do
#       it "sets the flash error" do
#
#       end
#     end
#
#     context "with any dates" do
#       it "redirects to referrer" do
#         post :create
#
#         expect(response).to redirect_to(request.referrer)
#       end
#     end
#   end
#
#   describe "DELETE #destroy" do
#     it "redirects to the cart" do
#       delete :destroy
#
#       expect(response).to redirect_to(cart_path)
#     end
#   end
#
#   describe "GET #show" do
#     it "renders the show template" do
#       get :show
#
#       expect(response).to render_template(:show)
#     end
#   end
# end
