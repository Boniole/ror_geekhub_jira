class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.memberships.exists?(user_id: user.id)
  end

  def create?
    true
  end

  def update?
    user.admin?(record)
  end

  def destroy?
    user.admin?(record)
  end
end
