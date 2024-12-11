FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "foobar@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
