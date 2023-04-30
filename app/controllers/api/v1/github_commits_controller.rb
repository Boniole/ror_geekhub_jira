class Api::V1::GithubCommitsController < ApplicationController
  include Githubable

  before_action :authorize_user, only: %i[show]

  def show
    render_success(data: git_branch_commits, status: :ok)
  end

  private

  def authorize_user
    authorize current_project.tasks.find(params[:id])
  end
end
