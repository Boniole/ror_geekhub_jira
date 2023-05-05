class MembershipPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    admin?(@record.project_id)
  end

  alias delete? create?
end
