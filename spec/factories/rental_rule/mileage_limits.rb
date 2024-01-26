FactoryBot.define do
  factory :rental_rule_mileage_limit, class: "RentalRule::MileageLimit" do
    owner { nil }
    title { "MyString" }
    value { 1 }
    markup { 1 }
    discount { 1 }
  end
end
