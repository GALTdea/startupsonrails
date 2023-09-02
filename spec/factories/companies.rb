# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  url        :string
#  about      :text
#  email      :string
#  location   :string
#  links      :string
#  tech_stack :text
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
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
