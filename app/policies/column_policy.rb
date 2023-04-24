class ColumnPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    user.admin?(@record.desk.project)
  end

  alias create? show?
  alias update? show?
  alias destroy? show?
end
