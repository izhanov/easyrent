FactoryBot.define do
  factory :rental_rule_age_restriction, class: "RentalRule::AgeRestriction" do
    owner { nil }
    age { 1 }
  end
end
