require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#price" do
    it "takes in a number and formats it to 2 digits" do
      expect(helper.price(2)).to eq("$2.00")
    end
  end

  describe "#link_to_reserve home" do
    it "returns a link to user_home_path" do
      home = create(:home)
      user = home.user
      expect(helper.link_to_reserve(home)).to eq("<a class=\"center price btn btn-one btn-wide center-block\" href=\"/#{user.slug}/homes/#{home.id}\">$100.00 Per Night</a>")
    end
  end

  describe "#link_to_reservation" do
    it "returns a link to the reservation" do
      home = create(:home)
      user = home.user
      reservation = {
        "home"     => home.id,
        "checkin"  => "01/01/2018",
        "checkout" => "01/01/2018"
      }
      reservation = CartReservation.new(reservation)
      expect(helper.link_to_reservation(reservation)).to eq("<a href=\"/#{user.slug}/homes/#{home.id}\">MyString</a>")
    end
  end

  describe "link_to_suspend_or_reactivate_button" do
    context "home is suspended" do
      it "creates a link to reactivate it" do
        home = create(:home)
        expect(helper.link_to_suspend_or_reactivate_button(home)).to eq(
          "<a class=\"btn btn-one\" rel=\"nofollow\" data-method=\"patch\" href=\"/admin/homes/#{home.id}/suspend\">Suspend</a>"
        )
      end
    end

    context "home is active" do
      it "creates a link to suspend it" do
        home = create(:suspended_home)
        expect(helper.link_to_suspend_or_reactivate_button(home)).to eq(
          "<a class=\"btn btn-one\" rel=\"nofollow\" data-method=\"patch\" href=\"/admin/homes/#{home.id}/reactivate\">Reactivate</a>"
        )
      end
    end
  end
end
