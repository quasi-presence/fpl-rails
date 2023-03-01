FactoryBot.define do
  factory :user do
    email { "joe.user@test.com" }
    password_digest { "MyString" }
  end
end
