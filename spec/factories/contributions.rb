FactoryBot.define do
  factory :contribution do
    name { "MyString" }
    description { "MyText" }
    github_url { "MyString" }
    company { nil }
  end
end
