class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :record
  # delete the same methods with alies
  def show?
    @record.memberships.exists?(user_id: user.id)
  end

  def create?
    true
  end

  def update?
    project_admin
  end

  def add_member?
    project_admin
  end

  def delete_member
    project_admin
  end

  def delete_member?
    project_admin
  end

  def destroy?
    project_admin
  end

  private

  def project_admin
    user.admin?(@record)
  end
end
