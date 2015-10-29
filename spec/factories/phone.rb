FactoryGirl.define do
  factory :phone do
    phone { Faker::PhoneNumber.cell_phone }
    contact
  end
end
