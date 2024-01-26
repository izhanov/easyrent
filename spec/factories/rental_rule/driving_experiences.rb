FactoryBot.define do
  factory :rental_rule_driving_experience, class: "RentalRule::DrivingExperience" do
    owner { nil }
    level { 1 }
  end
end
