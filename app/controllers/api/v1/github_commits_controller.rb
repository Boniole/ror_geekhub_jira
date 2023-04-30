class Api::V1::GithubCommitsController < ApplicationController
  include Githubable

  before_action :commit_params, :authorize_user, only: %i[show]

  def show
    render_success(data: git_get_branch_commits, status: :ok)
  end

  private

  def authorize_user
    authorize current_project.tasks.find(params[:id])
  end

  def commit_params
    params.permit(:sha)
  end
end
