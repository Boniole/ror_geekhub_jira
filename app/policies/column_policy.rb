class ColumnPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    user.admin?(@record.desk.project)
  end

  def show
    user.admin?(@record.desk.project) || member?(@record.desk.project_id)
  end

  alias update? create?
  alias destroy? create?
end
