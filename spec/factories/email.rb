FactoryGirl.define do
  factory :email do
    email { Faker::Internet.safe_email }
    contact
  end
end
