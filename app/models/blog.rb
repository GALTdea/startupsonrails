class Blog < ApplicationRecord
  belongs_to :user
  validates :title, :content, presence: true

  has_rich_text :content
end
