FactoryBot.define do
  factory :booking do
    car
    client
    offer
    starts_at { "2024-01-30 12:26:59" }
    ends_at { "2024-01-30 12:26:59" }
    actual_starts_at { "2024-01-30 12:26:59" }
    actual_ends_at { "2024-01-30 12:26:59" }
    pickup_location { "MyString" }
    drop_off_location { "MyString" }
    self_pickup { false }
    self_drop_off { false }
  end
end
