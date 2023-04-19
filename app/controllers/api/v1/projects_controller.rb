class Api::V1::ProjectsController < ApplicationController
  before_action :authorize_request
  before_action :project_params, only: %i[create update]
  before_action :set_projects, only: :index
  before_action :set_project, only: %i[show update destroy add_member delete_member]
  # before_action memberships, only: %i[show update destroy add_member delete_member]

  def index
    render json: @projects, status: :ok
  end

  def show
    authorize @project
    # add serializer
    render json: @project, status: :ok, serializer: Api::V1::ProjectSerializer
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = @current_user.id

    # before_auth authorize @project || Project
    authorize @project

    if @project.save
      # current_user.new
      membership = @project.memberships.new(user_id: @current_user.id, role: :admin)
      membership.save!
      render json: @project, status: :created, serializer: Api::V1::ProjectSerializer
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @project

    if @project.update(project_params)
      render json: @project, status: :ok, serializer: Api::V1::ProjectSerializer
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def add_member
    user = User.find(params[:user_id])
    # remove .first
    # rename to memberships
    existing_membership = @project.memberships.where(user:).first
    # .any?
    if existing_membership
      render json: { error: 'User is already a member of the project' }, status: :unprocessable_entity
    else
      # build rename to new
      membership = @project.memberships.build(user:, role: 'member')

      authorize @project

      if membership.save
        render json: membership, status: :created, serializer: Api::V1::MembershipSerializer
      else
        render json: membership.errors, status: :unprocessable_entity
      end
    end
  end

  def delete_member
    # move to before_action
    membership = @project.memberships.find_by(user_id: params[:user_id])
    # @memberships.find_by(user_id: params[:user_id])
    authorize @project # kill action before Project current_user
    membership.destroy
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
    params.permit(:name, :status, :git_url, :git_repo)
  rescue ActionController::ParameterMissing => e
    render json: { errors: e.message }, status: :bad_request
  end
end
