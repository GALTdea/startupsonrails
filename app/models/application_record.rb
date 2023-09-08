class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class


  def initials
    self.name.split.map(&:first).join
  end
end
