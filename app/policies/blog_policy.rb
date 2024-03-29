class BlogPolicy < ApplicationPolicy

  def index?
    !user.nil?
  end

  def new?
    !user.nil?
  end

  def create?
    !user.nil?
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
