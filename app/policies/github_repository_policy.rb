class GithubRepositoryPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    # remove record
    user.admin?(set_project)
  end

  def delete?
    user.admin?(set_project)
  end

  alias :update? :create?

  private

  #  remove to controller
  def set_project
    user.projects.find(@record.project_id)
  end
end
