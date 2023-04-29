class Api::V1::GithubBranchesController < ApplicationController
  include Githubable

  before_action :branch_params, only: %i[index create]
  before_action :set_task, only: %i[create]

  def index
    branches = github_client.branches(current_project.git_repo)

    render_success(data: branches.map { |branch| { name: branch.name, sha: branch.commit.sha } }, status: :ok)
  end

  def create
    branch = git_create_branch

    render_success(data: "Create new branch: #{@new_branch_name}", status: :ok) if branch.is_a?(Sawyer::Resource)
  end

  private

  def authorize_user
    authorize @task
  end

  def branch_params
    params.permit(:project_id, :task_id, :branch_name, :sha)
  end

  def set_task
    @task = current_project.tasks.find(params[:task_id])
  end
end
