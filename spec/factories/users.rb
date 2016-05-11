FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "user #{n}"
    end
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password Faker::Internet.password
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    description Faker::Hipster.sentence
    role 0
    sequence :slug do |n|
      "user-#{n}"
    end
  end
end
