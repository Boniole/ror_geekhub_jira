class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    member?(record)
  end

  def update?
    user.admin?(record)
  end

  alias add_member? update?
  alias delete_member? update?
  alias destroy? update?
end
