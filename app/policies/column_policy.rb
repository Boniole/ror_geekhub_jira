class ColumnPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    user.admin?(set_project) || member?(set_project)
  end

  def create?
    user.admin?(set_project)
  end

  def update?
    create?
  end

  def delete?
    user.admin?(set_project)
  end

  private

  def member?(project)
    project.memberships.exists?(user_id: user.id)
  end

  def set_project
    @record.desk.project
  end
end
