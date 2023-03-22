class Api::V1::ProjectsController < ApplicationController
  before_action :authorize_request
  before_action :project_params, only: %i[create update]
  before_action :set_projects, only: :index
  before_action :set_project, only: %i[show update destroy]

  def index
    render json: @projects, status: :ok
  end

  def show
    render json: @project, status: :ok
  end

  def create
    project = Project.new(project_params)
    project.user_id = @current_user.id

    if project.save
      render json: project, status: :created
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  def update
    return render json: @project, status: :ok if @project.update(project_params)

    render json: @project.errors, status: :unprocessable_entity
  end

  def destroy
    @project.destroy
  end

  private

  def set_project
    @project = Project.find(params[:id])
    if @project.user_id == @current_user.id
      @project
    else
      render json: { errors: 'User is not authorized to access this resource' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Project not found' }, status: :not_found
  end

  def set_projects
    @projects = Project.where(user_id: @current_user)
  end

  def project_params
    params.require(:project).permit(:name, :status)
  rescue ActionController::ParameterMissing
    render json: { error: 'Missing required parameter(s)' }, status: :bad_request
  end
end
