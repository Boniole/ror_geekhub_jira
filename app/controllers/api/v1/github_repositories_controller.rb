class Api::V1::GithubRepositoriesController < ApplicationController
  include Githubable

  before_action :repo_params, only: %i[create update]
  before_action :repo_delete_params, only: %i[delete]
  before_action :set_project, only: %i[update delete]
  after_action :project_git_info, only: %i[create delete]

  def create
    #validator
    repository = GithubRepository.new(repo_params)
    @project = current_user.projects.find(params[:project_id])

    # authorize GithubRepository

    if repository.valid? && @project.present?
      git_create_repo

      serialized_repository = Api::V1::GithubRepositorySerializer.new(@repo).as_json

      render_success(data: serialized_repository, status: :ok)
    else
      render_error(errors: repository.errors.full_messages)
    end
  end

  def update
    repository = GithubRepository.new(repo_params)

    # authorize repository

    if repository.valid? && @project.present?
      git_update_repo

      render_success(data: 'Repository update', status: :ok)
    else
      render_error(errors: repository.errors.full_messages)
    end
  end

  def delete
    owner, repo_name = params[:validate_text].split('/')

    if github_client.repository(@project.git_repo).full_name == params[:validate_text]
      github_client.delete_repository(owner: owner, repo: repo_name)

      render_success(data: 'Repository was deleted', status: :ok)
    else
      render_error(errors: 'Invalid validate text', status: :bad_request)
    end
  end

  private

  def repo_params
    params.permit(:project_id, :name, :description, :private, :has_issues, :has_downloads)
  end

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def repo_delete_params
    params.permit(:project_id, :validate_text)
  end
end
