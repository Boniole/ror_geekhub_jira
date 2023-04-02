class Api::V1::ProjectsController < ApplicationController
  before_action :authorize_request
  before_action :project_params, only: %i[create update]
  before_action :set_projects, only: :index
  before_action :set_project, only: %i[show update destroy]

  def index
    render json: @projects, status: :ok
  end

  def show
    authorize @project
    render json: { project: @project, member: @project.memberships }, status: :ok
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = @current_user.id
    @project.save
    @project.memberships.build(user_id: @current_user.id, role: 'admin')
    authorize @project

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])
    authorize @project

    if @project.update(project_params)
      if params[:membership] && params[:membership][:user_id].present?
        @user = User.find(params[:membership][:user_id])
        @membership = @project.memberships.build(user: @user, role: 'member')
        @membership.save
      end

      render json: @project, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @project
    @project.destroy
  end

  private

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def set_projects
    @projects = Project.where(user_id: @current_user)
  end

  def project_params
    params.require(:project).permit(:name, :status)
  rescue ActionController::ParameterMissing => e
    render json: { errors: e.message }, status: :bad_request
  end
end
