FactoryBot.define do
  factory :rental_rule_mileage_limit, class: "RentalRule::MileageLimit" do
    owner { nil }
    title { "Basic" }
    value { 200 }
    over_mileage_price { 10.0 }
    markup { 0 }
    discount { 0 }

    trait :owned_by_car_park do
      association :owner, factory: :car_park
    end
  end
end
