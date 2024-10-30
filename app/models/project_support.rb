class ProjectSupport < ApplicationRecord
  belongs_to :company
  belongs_to :open_source_project
end
