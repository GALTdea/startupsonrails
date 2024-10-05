class OpenSourceProjectPolicy < ApplicationPolicy
  def create?
    user.admin? || user.company == record.company
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
