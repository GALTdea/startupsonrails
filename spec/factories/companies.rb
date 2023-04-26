FactoryBot.define do
  factory :company do
    name { "MyString" }
    url { "MyString" }
    about { "MyText" }
    email { "MyString" }
    location { "MyString" }
    links { "MyString" }
    tech_stack { "MyText" }
    user { nil }
  end
end
