FactoryBot.define do
  factory :offer do
    car
    title { "Offer title" }
    mileage_limit_id { 1 }
    prices { {"1..10" => 10_000, "11..20" => 9_500, "21..30" => 9_000} }
    pledge_amount { 100_000 }
  end
end
