class TaskPolicy < ApplicationPolicy
  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

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
    Membership.where(project_id: task.project_id, user_id: user.id).exists?
  end

  def admin_or_owner?
    user.admin? || task.user_id == user.id
  end

  def admin_or_owner_or_assignee?
    user.admin? || task.assignee_id == user.id || task.user_id == user.id
  end

end
