class ColumnPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    admin?(@record.desk.project_id)
  end

  def show?
    member?(@record.desk.project_id)
  end

  alias update? create?
  alias destroy? create?
end
