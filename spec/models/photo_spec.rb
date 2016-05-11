require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:image) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:home) }
  end
end
