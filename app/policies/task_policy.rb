class TaskPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    project_member?
  end

  alias :create? :show?
  alias :update? :show?
  alias :destroy? :show?

  private

  # where to scopes
  def project_member?
    Membership.where(project_id: @record.project_id, user_id: user.id).exists?
  end

  def admin_or_owner?
    user.admin?(@record.project) || @record.user_id == user.id
  end
end
