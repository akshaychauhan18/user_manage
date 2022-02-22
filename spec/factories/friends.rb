FactoryBot.define do
  factory :friend do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    phone { Faker::PhoneNumber.phone_number }
    twitter { Faker::Twitter.user }
    association :user, factory: :random_user

    trait :no_twitter do
      twitter { nil }
    end
  end
end
