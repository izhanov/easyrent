FactoryBot.define do
  factory :contract do
    booking { nil }
    amount { "9.99" }
    rental_days { 1 }
    mileage_limit { 1 }
    pledge_return_method { "MyString" }
    pledge_return_date { "2024-04-01" }
    pledge_return_requisites { "MyString" }
  end
end
