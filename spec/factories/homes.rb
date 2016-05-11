FactoryGirl.define do
  factory :home do
    name "MyString"
    description "MyString"
    price_per_night "MyString"
    address "MyString"
    after(:create) do |home|
      home.photos << create(:photo)
    end
    user
  end
end
