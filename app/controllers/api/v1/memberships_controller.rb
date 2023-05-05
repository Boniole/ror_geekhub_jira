class Api::V1::MembershipsController < ApplicationController
  include NatsPublisher
  before_action :set_member, :set_membership, :authorize_user, only: %i[create destroy]
  
  def create
    if project_memberships.where(user: @user).any?
      render_error(errors: ['User is already a member of the project'])
    else
      membership = project_memberships.new(user: @user)

      if membership.save
        nats_publish('service.mail', { class: 'account',
                                       type: 'add_member_to_project',
                                       language: 'en',
                                       to: @user.email,
                                       project: @project.name,
                                       username: @user.first_name }.to_json)
        render_success(data: membership, status: :created, serializer: Api::V1::MembershipSerializer)
      else
        render_error(errors: membership.errors)
      end
    end
  end

  def destroy
    membership = project_memberships.find_by(user_id: @user.id)
    membership.destroy
  end

  private

  def authorize_user
    authorize @membership || Membership.find
  end

  def set_member
    @user = User.find_by(email: membership_params[:email])
  end

  def set_membership
    @membership = current_user.memberships.find_by(project_id: params[:project_id])
  end

  def project_memberships
    current_project.memberships
  end

  def membership_params
    params.permit(:project_id, :email)
  end
end
