FactoryBot.define do
  factory :car_inspection do
    date { "2024-03-19" }
    mileage { 1 }
    car { nil }
  end
end
