class ProjectSupport < ApplicationRecord
  belongs_to :company
  belongs_to :open_source_project

  validates :support_type, presence: true,
            inclusion: { in: %w[sponsorship contribution] }
  validates :company_id, uniqueness: {
    scope: [:open_source_project_id, :support_type],
    message: 'already supports this project in this way'
  }

  scope :sponsorship, -> { where(support_type: 'sponsorship') }
  scope :contribution, -> { where(support_type: 'contribution') }
end
