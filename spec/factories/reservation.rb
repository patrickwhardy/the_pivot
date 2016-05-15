FactoryGirl.define do
  factory :reservation do
    home
    checkin Date.parse("3/5/2017")
    checkout Date.parse("4/5/2017")

    factory :upcoming_reservation do
      checkin Faker::Date.forward(1)
      checkout Faker::Date.forward(10)
    end

    factory :past_reservation do
      checkin Faker::Date.backward(1)
      checkout Faker::Date.backward(10)
    end
  end
end
