class GithubRepositoryPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    user.admin?(user.projects.find(@record.project_id))
    debugger
  end

  def delete?
    # user.admin?(user.projects.find(@record.project_id))
    debugger
  end

  # alias update? create?
  # alias delete? create?
end
