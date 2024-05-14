class BlogPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    !user.nil?
  end

  def edit?
    user.present? && user.admin?
  end

  def update?
    user.admin?
  end
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.present?
        scope.all
      end
    end
  end
end
