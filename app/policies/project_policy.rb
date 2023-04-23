class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    @record.memberships.exists?(user_id: user.id)
  end

  def create?
    true
  end

  def update?
    project_admin
  end

  alias add_member? update?
  alias delete_member update?
  alias delete_member? update?
  alias destroy? update?

  private

  def project_admin
    user.admin?(@record)
  end
end
