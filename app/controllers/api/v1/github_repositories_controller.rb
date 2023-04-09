class Api::V1::GithubRepositoriesController < ApplicationController
  before_action :authorize_request, :authorize_github
  before_action :repo_create_params, only: %i[create]
  before_action :repo_delete_params, only: %i[delete]
  before_action :set_project, only: %i[delete]

  def create
    repository = GithubRepository.new(repo_create_params)
    @project = @current_user.projects.find(params[:project_id])

    authorize repository

    if repository.valid? && @project.present?
      repo = @github_client.create_repository(
        params[:name],
        description: params[:description],
        private: params[:private],
        has_issues: params[:has_issues],
        has_downloads: params[:has_downloads]
      )

      @project.git_url = repo.clone_url
      @project.git_name = repo.name
      @project.save

      render json: {
        name: repo.name,
        description: repo.description,
        url: repo.html_url,
        git_url: repo.git_url
      }, status: :ok

    else
      render json: { errors: repository.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete
    owner, repo_name = params[:validate_text].split('/')
    get_repo = @github_client.search_repositories(repo_name)

    if get_repo.items[0].full_name == params[:validate_text]
      @github_client.delete_repository(
        owner: owner,
        repo: repo_name
      )
      render json: { success: 'Repository was deleted' }, status: :ok
    else
      render json: { errors: 'Invalid validate text' }, status: :bad_request
    end
  end

  private

  def repo_create_params
    params.permit(:project_id, :name, :description, :private, :has_issues, :has_downloads)
  rescue ActionController::ParameterMissing => e
    render json: { errors: e.message }, status: :bad_request
  end

  def set_project
    @project = @current_user.projects.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def repo_delete_params
    params.permit(:project_id, :validate_text)
  rescue ActionController::ParameterMissing => e
    render json: { errors: e.message }, status: :bad_request
  end
end
