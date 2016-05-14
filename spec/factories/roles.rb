FactoryGirl.define do
  factory :role do
    role "user"

    factory :admin_role do
      role "admin"
    end
  end
end
