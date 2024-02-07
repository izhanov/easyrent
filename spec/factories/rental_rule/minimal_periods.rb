FactoryBot.define do
  factory :rental_rule_minimal_period, class: "RentalRule::MinimalPeriod" do
    owner { nil }
    value { 1 }

    trait :owned_by_car_park do
      association :owner, factory: :car_park
    end
  end
end
