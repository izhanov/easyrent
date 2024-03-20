FactoryBot.define do
  factory :car_inspection do
    start_at { "2024-03-19" }
    end_at { "2025-03-19" }
    car { nil }
  end
end
