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

    factory :deleted_user do
      status 1
    end

    factory :admin do
      sequence :username do |n|
        "admin_user #{n}"
      end
      sequence :email do |n|
        "admin_user#{n}@example.com"
      end
      after(:create) do |admin|
        admin.roles << create(:admin_role)
      end
    end
  end
end
