class Api::V1::GithubCommitsController < ApplicationController
  include Githubable

  before_action :set_task, :authorize_user, only: %i[show]

  def show
    render_success(data: git_branch_commits, status: :ok)
  end

  private

  def authorize_user
    authorize @task || Task.find
  end

  def set_task
    @task = current_project.tasks.find(params[:id]) if current_project.present?
  end
end
