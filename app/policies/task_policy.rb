class TaskPolicy < ApplicationPolicy
  def show?
    project_member?
  end

  def create?
    project_member?
  end

  def update?
    admin_or_owner_or_assignee?
  end

  def destroy?
    admin_or_owner?
  end

  private

  def project_member?
    Membership.where(project_id: record.project_id, user_id: user.id).exists?
  end

  def admin_or_owner?
    user.admin?(record.project) || record.user_id == user.id
  end

  def admin_or_owner_or_assignee?
    user.admin?(record.project) || record.assignee_id == user.id || record.user_id == user.id
  end
end
