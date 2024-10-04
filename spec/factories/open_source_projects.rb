FactoryBot.define do
  factory :open_source_project do
    name { "MyString" }
    description { "MyText" }
    project_type { "MyString" }
    url { "MyString" }
    icon_url { "MyString" }
    stars { 1 }
    forks { 1 }
    company { nil }
  end
end
