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
class Company < ApplicationRecord
  has_many :categorizations
  has_many :categories, through: :categorizations

  extend FriendlyId
  belongs_to :user
  
  friendly_id :name, use: :slugged
  
  validates :name, :url, :user_id, presence: true
end
