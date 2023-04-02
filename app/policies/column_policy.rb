class ColumnPolicy < ApplicationPolicy
  def show?
    user.admin?(set_project) || user.member?(set_project)
  end

  def create?
    user.admin?(set_project)
  end

  def update
    create?
  end

  def delete
    create?
  end

  private

  def member?(project)
    project.memberships.exists?(user_id: user.id)
  end

  def set_project
    record.columnable.project
  end
end
