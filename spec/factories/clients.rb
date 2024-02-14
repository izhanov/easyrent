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
    bank_account_number { "KZ123456789012345678" }
  end

  trait :legal do
    kind { "legal" }
    full_name_of_the_head { "John Doe" }
    legal_address { "Almaty, Kazakhstan" }
    bank_code { "KZ123456" }
    bank_account_number { "KZ123456789012345678" }
    signed_on_basis { "John Doe" }
  end

  trait :individual do
    kind { "individual" }
  end
end
