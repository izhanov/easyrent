FactoryBot.define do
  factory :booking_give_out_appendix do
    booking { nil }
    mileage_before_rent { 1 }
    fuel_level_before_rent { 1 }
    appearance_before_rent { "MyString" }
    technical_condition_before_rent { "MyString" }
  end
end
