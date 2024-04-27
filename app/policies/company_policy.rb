class CompanyPolicy < ApplicationPolicy

  def new?
    user.admin?
  end

  def edit?
    user.admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
