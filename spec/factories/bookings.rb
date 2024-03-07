FactoryBot.define do
  factory :booking do
    car
    client
    offer
    starts_at { "2024-01-30 12:26:59" }
    ends_at { "2024-01-30 12:26:59" }
    actual_starts_at { "2024-01-30 12:26:59" }
    actual_ends_at { "2024-01-30 12:26:59" }
    pledge_amount { "9.99" }
    pickup_location { "MyString" }
    drop_off_location { "MyString" }
    self_pickup { false }
    self_drop_off { false }


    trait :confirmed do
      status { "confirmed" }
    end

    trait :payment_accepted do
      status { "payment_accepted" }
    end

    trait :give_out_the_car do
      status { "give_out_the_car" }
    end

    trait :car_in_rent do
      status { "car_in_rent" }
    end

    trait :accept_the_car do
      status { "accept_the_car" }
    end

    trait :return_the_deposit do
      status { "return_the_deposit" }
    end

    trait :canceled do
      status { "cancelled" }
    end

    trait :finished do
      status { "finished" }
    end
  end
end
