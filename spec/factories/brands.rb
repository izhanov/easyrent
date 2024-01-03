FactoryBot.define do
  factory :brand do
    title { Faker::Vehicle.make }
  end
end
