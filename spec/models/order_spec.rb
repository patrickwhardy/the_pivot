require 'rails_helper'

RSpec.describe Order, type: :model do
  it {should have_many :order_tools}
end
