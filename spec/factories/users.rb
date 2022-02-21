FactoryBot.define do
  factory :random_user, class: User do
    # sequence(:user_id) { |number| number }
    email { Faker::Internet.safe_email }
    password { Devise.friendly_token.first(6) }
  end
end
