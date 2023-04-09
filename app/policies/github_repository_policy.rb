class GithubRepositoryPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    user.admin?(set_project)
  end

  def update?
    create?
  end

  def delete?
    user.admin?(set_project)
  end

  private

  def set_project
    user.projects.find(@record.project_id)
  end
end
