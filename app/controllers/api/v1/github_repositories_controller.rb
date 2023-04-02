class Api::V1::GithubRepositoriesController < ApplicationController
  before_action :authorize_request, :authorize_github
  before_action :repo_create_params, only: %i[create]
  before_action :repo_delete_params, only: %i[delete]
  before_action :set_project, only: %i[delete]

  def create
# debugger
@contact_form = GithubRepository.new(repo_create_params)
    debugger
      # repo = @github_client.create_repository(
      #   params[:name],
      #   description: params[:description],
      #   private: params[:private],
      #   has_issues: params[:has_issues],
      #   has_downloads: params[:has_downloads]
      # )
  
      # render json: { name: repo.name, description: repo.description, url: repo.html_url }, status: :ok
  end

  def delete
    # debugger 
    # project.find_by(git_name: value)
# debugger
    # if (params[:validate_text]).include? @project.user.name

    @github_client.delete_repository(
      owner: 'xiosky90',
      repo: '1122223'
    )

    render json: { success: 'Repository was deleted' }, status: :ok
  end

  private

  def repo_create_params
    params.permit(:name, :description, :private, :has_issues, :has_downloads)
  rescue ActionController::ParameterMissing => e
    render json: { errors: e.message }, status: :bad_request
  end

  def set_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def repo_delete_params
    params.permit(:project_id, :validate_text)
  rescue ActionController::ParameterMissing => e
    render json: { errors: e.message }, status: :bad_request
  end
end
