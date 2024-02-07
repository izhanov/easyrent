FactoryBot.define do
  factory :booking do
    car { nil }
    client { nil }
    offer { nil }
    start_datetime { "2024-01-30 12:26:59" }
    end_datetime { "2024-01-30 12:26:59" }
    actual_start_datetime { "2024-01-30 12:26:59" }
    actual_end_datetime { "2024-01-30 12:26:59" }
    pickup_location { "MyString" }
    drop_off_location { "MyString" }
    self_pickup { false }
    self_drop_off { false }
  end
end
