class Issue < ApplicationRecord
  belongs_to :open_source_project
  has_many :project_supports, through: :open_source_project
  has_many :companies, through: :project_supports

  attr_accessor :github_issue

  enum status: { pending: 0, active: 1, resolved: 2, closed: 3 }
end
