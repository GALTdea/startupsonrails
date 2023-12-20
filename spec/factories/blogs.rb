FactoryBot.define do
  factory :blog do
    title { "MyString" }
    published_at { "MyString" }
    category { "MyString" }
    user { nil }
    status { "MyString" }
  end
end
