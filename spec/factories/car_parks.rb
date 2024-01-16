FactoryBot.define do
  factory :car_park do
    city
    user
    title { Faker::Company.name }
    business_id_number { Faker::Company.ein }
    kind { "llp" }
  end
end
