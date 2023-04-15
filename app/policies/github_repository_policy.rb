class GithubRepositoryPolicy < ApplicationPolicy
  attr_reader :user, :record
  # delete the same methods with alies
  def create?
    # remove record
    user.admin?(set_project)
  end

  def update?
    create?
  end

  def delete?
    user.admin?(set_project)
  end

  private

  #  remove to controller
  def set_project
    user.projects.find(@record.project_id)
  end
end
