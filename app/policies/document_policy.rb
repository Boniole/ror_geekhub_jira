class DocumentPolicy < ApplicationPolicy
  def show?
    user_is_project_member?
  end

  def create?
    user_is_project_member?
  end

  def update?
    user_is_file_author_or_admin?
  end

  def destroy?
    user_is_file_author_or_admin?
  end

  private

  def user_is_project_member?
    record.project.members.include?(user)
  end

  def user_is_file_author_or_admin?
    record.user == user || user.admin?
  end
end
