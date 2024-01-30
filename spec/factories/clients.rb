FactoryBot.define do
  factory :client do
    phone { "MyString" }
    identification_number { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    patronymic { "MyString" }
    email { "MyString" }
    passport_type { "MyString" }
    passport_number { "MyString" }
    driver_license_number { "MyString" }
    driver_license_issued_date { "2024-01-29" }
    residence { false }
    kind { "MyString" }
  end
end
