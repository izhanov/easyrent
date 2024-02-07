FactoryBot.define do
  factory :rental_rule_age_restriction, class: "RentalRule::AgeRestriction" do
    owner { nil }
    value { 18 }

    trait :owned_by_car_park do
      association :owner, factory: :car_park
    end
  end
end
