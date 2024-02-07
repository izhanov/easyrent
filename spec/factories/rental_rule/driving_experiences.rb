FactoryBot.define do
  factory :rental_rule_driving_experience, class: "RentalRule::DrivingExperience" do
    owner { nil }
    value { 1 }

    trait :owned_by_car_park do
      association :owner, factory: :car_park
    end
  end
end
