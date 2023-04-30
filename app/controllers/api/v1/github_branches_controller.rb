class Api::V1::GithubBranchesController < ApplicationController
  include Githubable

  before_action :set_task, :authorize_user, only: %i[show create]

  def index
    authorize current_project
    render_success(data: git_get_brenches, status: :ok)
  end

  def show
    render_success(data: git_task_brenches(@task.tag_name), status: :ok)
  end

  def create
    branch = git_create_branch
    render_success(data: ["Create new branch: #{@new_branch_name}"], status: :ok) if branch.is_a?(Sawyer::Resource)
  end

  private

  def authorize_user
    authorize @task
  end

  def set_task
    task_id = params[:task_id] || params[:id]
    @task = current_project.tasks.find(task_id)
  end
end
