FactoryBot.define do
  factory :consumable_log do
    consumable { nil }
    date { "2024-03-20" }
    mileage_when_replacing { 1 }
    mileage_at_next_replacing { 1 }
    description { "MyString" }
  end
end
