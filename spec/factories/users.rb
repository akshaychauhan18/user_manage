FactoryBot.define do
  factory :random_user, class: User do
    email { Faker::Internet.safe_email }
    password { Devise.friendly_token.first(6) }

    trait :duplicate_email do
      email { "a@gmail.com" }
    end
  end
end
