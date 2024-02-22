FactoryBot.define do
  factory :car do
    mark
    owner_id { nil }
    owner_type { nil }
    year { 2021 }
    engine_capacity { 1.6 }
    engine_capacity_unit { "l" }
    transmission { "automatic" }
    fuel { "gas" }
    tank_volume { 50 }
    number_of_seats { 4 }
    mileage { 10_000 }
    technical_certificate_number { "1234567890" }
    plate_number { "AA1234AA" }
    vin_code { "1234567890" }
    klass { "economy" }
    status { "vacant" }

    trait :belongs_to_car_park do
      association :owner, factory: :car_park
    end
  end
end
