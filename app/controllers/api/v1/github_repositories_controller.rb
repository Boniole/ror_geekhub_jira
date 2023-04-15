class Api::V1::GithubRepositoriesController < ApplicationController
  before_action :authorize_request, :authorize_github
  before_action :repo_params, only: %i[create update]
  before_action :repo_delete_params, only: %i[delete]
  before_action :set_project, only: %i[delete update]

  def create
    #validator
    repository = GithubRepository.new(repo_params)
    #current_user
    @project = @current_user.projects.find(params[:project_id])

    # authorize GithubRepository

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
      # @project.update
      @project.save


      #
      # attribute :changed_files do
      #   object[:changed_files]
      # end
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

  def update
    repository = GithubRepository.new(repo_params)

    authorize repository
    repo_name = get_repository_name(params[:name])
#concerne github repository
    if repository.valid? && @project.present?
      repo = @github_client.edit_repository(
        repo_name,
        description: params[:description],
        private: params[:private],
        has_issues: params[:has_issues],
        has_downloads: params[:has_downloads]
      )

      @project.git_url = repo.clone_url
      @project.git_name = repo.name
      #update
      @project.save

      render json: { success: 'Repository update' }, status: :ok
    else
      render json: { errors: repository.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete
    owner, repo_name = params[:validate_text].split('/')

    @project.git_url = nil
    @project.git_name = nil
    #update
    @project.save
# user/repo
    if get_repository_name(repo_name) == params[:validate_text]
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

  def get_repository_name(name)
    #repository 
    repository = @github_client.search_repositories(name)
    repository.items[0].full_name
  end

  def repo_params
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
