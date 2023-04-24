class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    @record.memberships.exists?(user_id: user.id)
  end

  def create?
    true
  end

  def update?
    user.admin?(@record)
  end

  alias add_member? update?
  alias delete_member update?
  alias delete_member? update?
  alias destroy? update?
end
