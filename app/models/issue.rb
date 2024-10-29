class Issue < ApplicationRecord
  belongs_to :open_source_project
  has_one :company, through: :open_source_project

  attr_accessor :github_issue

  enum status: { pending: 0, active: 1, resolved: 2, closed: 3 }
end
