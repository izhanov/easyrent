FactoryBot.define do
  factory :rental_rule_over_mileage_price, class: "RentalRule::OverMileagePrice" do
    rental_rule_mileage_limit { nil }
    value { "9.99" }
  end
end
