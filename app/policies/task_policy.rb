class TaskPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    project_member?
  end

  def create?
    project_member?
  end

  def update?
    project_member?
  end

  def destroy?
    admin_or_owner?
  end

  private

  def project_member?
    Membership.where(project_id: @record.project_id, user_id: user.id).exists?
  end

  def admin_or_owner?
    user.admin?(@record.project) || @record.user_id == user.id
  end
end
