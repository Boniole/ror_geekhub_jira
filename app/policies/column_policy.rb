class ColumnPolicy < ApplicationPolicy
  attr_reader :user, :record

  # delete the same methods with alies
  def show?
    user.admin?(set_project) || member?(set_project)
  end

  def create?
    true
    # user.admin?(set_project)
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

  # move to controller
  def set_project
    @record.desk.project
  end
end
