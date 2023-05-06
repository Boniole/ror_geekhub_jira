class Api::V1::ProjectsController < ApplicationController
  before_action :project_params, only: %i[create update]
  before_action :set_projects, only: :index
  before_action :set_project, :authorize_user, only: %i[show update destroy]
  before_action :memberships, only: %i[update destroy]

  def index
    render_success(data: @projects, each_serializer: Api::V1::ProjectSerializer)
  end

  def show
    render_success(data: @project, serializer: Api::V1::ProjectSerializer)
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      membership = @project.memberships.new(user_id: current_user.id, role: :admin)
      membership.save!

      render_success(data: @project, status: :created, serializer: Api::V1::ProjectSerializer)
    else
      render_error(errors: @project.errors)
    end
  end

  def update
    if @project.update(project_params)
      render_success(data: @project, serializer: Api::V1::ProjectSerializer)
    else
      render_error(errors: @project.errors)
    end
  end

  def destroy
    @project.destroy
  end

  private

  def memberships
    @project.memberships
  end

  def authorize_user
    authorize @project || Project.find
  end

  def set_project
    @project = current_project(params[:id])
  end

  def set_projects
    @projects = current_user.memberships.map(&:project)
  end

  def project_params
    params.permit(:name, :status, :git_url, :git_repo)
  end
end
