class Api::V1::ProjectsController < ApplicationController
  before_action :project_params, only: %i[create update]
  before_action :set_projects, only: :index
  before_action :set_project, :authorize_user, only: %i[show update destroy add_member delete_member]
  before_action :memberships, only: %i[update destroy add_member delete_member]
  before_action :set_member, only: %i[add_member delete_member]

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
    existing_membership = memberships.where(user: @user)

    if existing_membership.any?
      render_error(errors: ['User is already a member of the project'])
    else
      membership = memberships.new(user: @user)

      if membership.save
        # SEND MAIL HERE
        render_success(data: membership, status: :created, serializer: Api::V1::MembershipSerializer)
      else
        render_error(errors: membership.errors)
      end
    end
  end

  def delete_member
    membership = memberships.find_by(user_id: @user.id)
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

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def set_projects
    @projects = current_user.projects
  end

  def set_member
    @user = User.find_by(email: params[:email])
  end

  def project_params
    params.permit(:name, :status, :git_url, :git_repo)
  end
end
