FactoryGirl.define do
  factory :contact do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    transient do
      emails_count 2
      phones_count 1
    end

    after(:build) do |contact, evaluator|
      contact.emails << build_list(:email, evaluator.emails_count, contact: nil)
      contact.phones << build_list(:phone, evaluator.phones_count, contact: nil)
    end
  end
end
