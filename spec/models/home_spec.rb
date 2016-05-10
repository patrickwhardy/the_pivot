require "rails_helper"

RSpec.describe Home, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price_per_night) }
    it { is_expected.to validate_presence_of(:address) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
