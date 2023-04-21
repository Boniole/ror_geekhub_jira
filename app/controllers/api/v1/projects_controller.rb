class Api::V1::ProjectsController < ApplicationController
  before_action :project_params, only: %i[create]
  before_action :set_projects, only: :index
  before_action :set_project, :authorize_user, only: %i[show update destroy add_member delete_member]
  before_action :memberships, only: %i[update destroy add_member delete_member]

  def index
    render_success(data: @projects, each_serializer: Api::V1::ProjectSerializer)
  end

  def show
    render_success(data: @project, serializer: Api::V1::ProjectSerializer)
  end

  def create
    @project = current_user.projects.new(project_params)
    authorize @project
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

  def add_member
    user = User.find(params[:user_id])
    existing_membership = memberships.where(user:)

    if existing_membership.any?
      render json: { error: 'User is already a member of the project' }, status: :unprocessable_entity
    else
      membership = memberships.new(user:)

      if membership.save
        render_success(data: membership, status: :created, serializer: Api::V1::MembershipSerializer)
      else
        render_error(errors: membership.errors)
      end
    end
  end

  def delete_member
    membership = memberships.find_by(user_id: params[:user_id])
    # authorize @project #kill action before Project current_user
    membership.destroy
  end

  def destroy
    @project.destroy
  end

  private

  def memberships
    @project.memberships
  end

  def authorize_user
    authorize @project || Project
  end

  # TODO: method update and delete cant see current_user
  def set_project
    @project = current_user.projects.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def set_projects
    # TODO: think about project where user is member
    @projects = current_user.projects
  end

  def project_params
    params.permit(:name, :status, :git_url, :git_repo)
  rescue ActionController::ParameterMissing => e
    render json: { errors: e.message }, status: :bad_request
  end
end
