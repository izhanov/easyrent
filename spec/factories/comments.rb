FactoryBot.define do
  factory :comment do
    content { "comment text" }
    commentable { nil }
  end
end
