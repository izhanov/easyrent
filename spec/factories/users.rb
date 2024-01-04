FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    password { "password" }

    trait :with_temp_password do
      temp_password { "12345678" }
      password { "12345678" }
      password_confirmation { "12345678" }
    end
  end
end
