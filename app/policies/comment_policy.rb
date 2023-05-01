class CommentPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    member?(@record.commentable.project_id)
  end

  def update?
    @record.user == user || admin?(@record.commentable.project_id)
  end

  alias destroy? update?
end
