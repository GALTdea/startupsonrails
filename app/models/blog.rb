class Blog < ApplicationRecord
  belongs_to :user
  validates :title, :content, presence: true

  has_rich_text :content

  has_one_attached :image

  private

  def image_attached?
    image.attached?
  end
end
