FactoryGirl.define do
  factory :home do
    name "MyString"
    description "MyString"
    price_per_night 100
    address "MyString"
    after(:create) do |home|
      home.photos << create(:photo)
    end
    user
  end
end
