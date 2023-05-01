class Api::V1::GithubPullrequestsController < ApplicationController
  include Githubable

  before_action :set_task, :authorize_user, only: %i[create]

  def create
    git_pullrequest
    render_success(data: @pullrequest, status: :ok) if @pullrequest.is_a?(Sawyer::Resource)
  end

  private

  def authorize_user
    authorize @task || Task.find
  end

  def set_task
    @task = current_project.tasks.find(params[:id]) if current_project.present?
  end
end
