class Api::V1::ProjectsController < ApplicationController
  before_action :project_params, only: %i[index create update]
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

    if project.save
      render json: project, status: :created
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  # TODO catch errors(Vlad)
  def update
    render json: @project, status: :ok if @project.update(project_params)
  end

  # TODO catch errors(Vlad)
  def destroy
    render json: @project, status: :ok if @project.destroy
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_projects
    @projects = Project.where(user_id: project_params)
  end

  def project_params
    params.require(:project).permit(:name, :status, :user_id)
  end
end
