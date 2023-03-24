class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    record.users.include?(user)
  end

  def update?
    admin_or_owner?
  end

  def destroy?
    admin_or_owner?
  end

  private

  def admin_or_owner?
    record.admin == user || record.owner == user
  end
end
