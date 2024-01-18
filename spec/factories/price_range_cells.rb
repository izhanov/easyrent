FactoryBot.define do
  factory :price_range_cell do
    price_range { nil }
    from { "MyString" }
    to { "MyString" }
  end
end
