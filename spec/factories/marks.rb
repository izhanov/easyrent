FactoryBot.define do
  factory :mark do
    brand
    title { Faker::Vehicle.make_and_model }
    body { "sedan" }
    synonyms { [Faker::Vehicle.model] }
  end
end
