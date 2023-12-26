class Blog < ApplicationRecord
  belongs_to :user
  validates :title, :content, presence: true

  has_rich_text :content

  has_one_attached :image
  before_save :set_image_key, if: :image_attached?
  private

  def image_attached?
    image.attached?
  end

  def set_image_key
    if image.attached?
      image.blob.update!(key: "blog-images/#{SecureRandom.uuid}-#{image.filename}")
    end
  end
end
