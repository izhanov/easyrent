FactoryBot.define do
  factory :price_range do
    owner { nil }
    unit { "day" }

    trait :owned_by_car_park do
      association :owner, factory: :car_park
    end
  end
end
