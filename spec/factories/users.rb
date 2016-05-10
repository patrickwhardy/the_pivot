FactoryGirl.define do
  factory :user do
    username Faker::Internet.user_name
    email Faker::Internet.email
    password Faker::Internet.password
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    description Faker::Hipster.sentence
    role 0
  end
end
