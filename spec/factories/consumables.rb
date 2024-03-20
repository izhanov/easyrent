FactoryBot.define do
  factory :consumable do
    car { nil }
    title { "MyString" }
    description { "MyString" }
    lifetime { 1 }
  end
end
