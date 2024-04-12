FactoryBot.define do
  factory :booking_acceptance_appendix do
    booking { nil }
    mileage_after_rent { 1 }
    fuel_level_after_rent { 1 }
    car_wash_amount { "9.99" }
    fine_amount { "9.99" }
    return_from_address_amount { "9.99" }
  end
end
