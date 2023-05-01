class TaskPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    member?(@record.project_id)
  end

  alias create? show?
  alias update? show?
  alias destroy? show?
end
