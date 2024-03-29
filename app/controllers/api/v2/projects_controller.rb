class Api::V2::ProjectsController < ApplicationController
  include NatsPublisher

  before_action :project_params, only: %i[create update]
  before_action :set_projects, only: :index
  before_action :set_project, :authorize_user, only: %i[show update destroy add_member delete_member]
  before_action :memberships, only: %i[update destroy add_member delete_member]
  before_action :set_member, only: %i[add_member delete_member]

  def index
    render_success(data: @projects, each_serializer: Api::V2::ProjectSerializer)
  end

  def show
    render_success(data: @project, serializer: Api::V2::ProjectSerializer)
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      membership = @project.memberships.new(user_id: current_user.id, role: :admin)
      membership.save!

      render_success(data: @project, status: :created, serializer: Api::V2::ProjectSerializer)
    else
      render_error(errors: @project.errors)
    end
  end

  def update
    if @project.update(project_params)
      render_success(data: @project, serializer: Api::V2::ProjectSerializer)
    else
      render_error(errors: @project.errors)
    end
  end

  def add_member
    existing_membership = memberships.where(user: @user)
    if existing_membership.any?
      nats_publish('service.mail', { class: 'account',
                                     type: 'add_member_to_project',
                                     language: 'en',
                                     to: @user.email,
                                     project: @project.name,
                                     username: @user.first_name }.to_json)
      render json: { error: 'User is already a member of the project' }, status: :unprocessable_entity
    else
      membership = @project.memberships.new(user: @user)

      if membership.save
        render_success(data: membership, status: :created, serializer: Api::V2::MembershipSerializer)
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
    @project = current_project(params[:id])
  end

  def set_projects
    @projects = current_user.memberships.map(&:project)
  end

  def set_member
    @user = User.find_by(email: params[:email])
  end

  def project_params
    params.permit(:name, :status, :git_url, :git_repo)
  end
end
