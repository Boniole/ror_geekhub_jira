class DocumentPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    project_member?
  end

  def create?
    project_member?
  end

  def update?
    user_is_file_author_or_admin?
  end

  def destroy?
    user_is_file_author_or_admin?
  end

  private

  def project_member?
    @record.project.memberships.exists?(user_id: user.id)
  end

  def user_is_file_author_or_admin?
    @record.user == user || user.admin?
  end
end
