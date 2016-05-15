FactoryGirl.define do
  factory :order do
    user
    total "100"

    factory :paid_order do
      status 1
    end

    factory :completed_order do
      status 2
    end

    factory :cancelled_order do
      status 3
    end
  end
end
