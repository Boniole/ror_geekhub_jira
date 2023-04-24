class GithubRepositoryPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    user.admin?(user.projects.find(@record.project_id))
  end

  alias update? create?
  alias delete? create?
end
