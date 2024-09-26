FactoryBot.define do
  factory :issue do
    title { "MyString" }
    description { "MyText" }
    github_url { "MyString" }
    company { nil }
  end
end
