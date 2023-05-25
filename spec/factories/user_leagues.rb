FactoryBot.define do
  factory :user_league do
    association :owner, factory: :user
    name { "Fast & Furious" }
  end
end
