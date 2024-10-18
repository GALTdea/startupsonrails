class Issue < ApplicationRecord
  belongs_to :open_source_project
  has_one :company, through: :open_source_project
end
