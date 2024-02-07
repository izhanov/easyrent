FactoryBot.define do
  factory :client do
    phone { "+77023870747" }
    identification_number { "530926461171" }
    name { "Joe" }
    surname { "Doe" }
    patronymic { "Malkovich" }
    email { "joedoe@mail.com" }
    passport_number { "N345982" }
    driving_license { "BK 213422" }
    driving_license_issued_date { "2018-01-29" }
    citizen { true }
    kind { "individual" }
  end
end
