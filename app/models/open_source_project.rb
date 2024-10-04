class OpenSourceProject < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :description, presence: true
  validates :project_type, presence: true, inclusion: { in: %w[contribution sponsorship] }
  validates :url, presence: true, url: true
  validates :icon_url, url: true, allow_blank: true
  validates :stars, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :forks, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  scope :contributions, -> { where(project_type: 'contribution') }
  scope :sponsorships, -> { where(project_type: 'sponsorship') }
end
