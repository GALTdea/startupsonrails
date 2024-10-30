FactoryBot.define do
  factory :project_support do
    company { nil }
    open_source_project { nil }
    support_type { "MyString" }
    details { "MyText" }
    started_at { "2024-10-30 13:21:23" }
  end
end
