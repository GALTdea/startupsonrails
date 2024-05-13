class Blog < ApplicationRecord
  belongs_to :user
  validates :title, :content, presence: true

  has_rich_text :content

  has_one_attached :image

  enum status: { draft: 0, published: 1, featured: 2 }

  # FEATURED = Blog.where(status: :featured).order(created_at: :desc).limit(3)

  def self.featured
    where(status: :featured).order(created_at: :desc).limit(3)
  end


end
