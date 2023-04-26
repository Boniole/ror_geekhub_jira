class Api::V1::UsersController < ApplicationController
  include NatsPublisher
  include TokenGenerationable

  skip_before_action :authorize_request, only: :create
  before_action :set_user, only: :show

  def show
    render_success(data: @user, serializer: Api::V1::UserSerializer)
  end

  def show_current_user
    render_success(data: current_user, serializer: Api::V1::UserSerializer)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token_data = generate_token(@user.id)
      # Move to concerns
      nats_publish('service.mail', { class: 'account',
                                     type: 'account_register_new',
                                     language: 'en',
                                     password: @user.password,
                                     to: @user.email,
                                     username: @user.first_name }.to_json)
      render_success(data: {
                       token: token_data[:token],
                       expiration_date: token_data[:expiration_date],
                       user: @user
                     })
    else
      render_error(errors: @user.errors.full_messages)
    end
  end

  def update
    if current_user.update(first_name: params[:first_name], last_name: params[:last_name])
      render_success(data: current_user, serializer: Api::V1::UserSerializer)
    else
      render_error(errors: current_user.errors.full_messages)
    end
  end

  def destroy
    current_user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :github_token)
  end
end
