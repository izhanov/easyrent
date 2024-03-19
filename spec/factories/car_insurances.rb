FactoryBot.define do
  factory :car_insurance do
    start_at { "2024-03-19" }
    end_at { "2024-03-19" }
    kind { "MyString" }
    car { nil }
  end
end
