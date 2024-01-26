FactoryBot.define do
  factory :rental_rule_minimal_period, class: "RentalRule::MinimalPeriod" do
    owner { nil }
    value { 1 }
  end
end
