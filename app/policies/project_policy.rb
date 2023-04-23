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

  add alias_method :add_member?, :update?
  add alias_method :delete_member, :update?
  add alias_method :delete_member?, :update?
  add alias_method :destroy?, :update?

  private

  def project_admin
    user.admin?(@record)
  end
end
