class ColumnPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    user.admin?(user) || member?(@record.desk.project)
  end

  def create?
    user.admin?(user)
  end

  def update
    create?
  end

  def delete
    user.admin?(user)
  end

  private

  def member?(project)
    project.memberships.exists?(user_id: user.id)
  end
end
