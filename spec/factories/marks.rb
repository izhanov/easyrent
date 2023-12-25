FactoryBot.define do
  factory :mark do
    brand
    title { "Gotham Knight" }
    body { "sedan" }
    synonyms { ["goat", "pussy wagon"] }
  end
end
