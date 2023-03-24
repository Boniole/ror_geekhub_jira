class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.project.users.include?(user)
  end

  def show?
    record.project.users.include?(user)
  end

  def update?
    admin_or_owner? || record.executor == user
  end

  def destroy?
    admin_or_owner? || record.executor == user
  end

  private

  def admin_or_owner?
    record.project.admin == user || record.project.owner == user
  end
end
