class Api::V1::UsersController < ApplicationController
  include NatsPublisher
  include Regexable

  skip_before_action  :authorize_request, only: :create
  before_action :set_user, except: %i[index show create destroy]

  # remove index
  def index
    @users = User.all
    render json: @users, status: :ok, include: [], each_serializer: Api::V1::UserSerializer
  end

  def show
    render json: @user, status: :ok, serializer: Api::V1::UserSerializer
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(user_id: @user.id) # to method or concern
      time = Time.now + 24.hours.to_i # to method or concern
      # nats_publish('service.mail', {:class => "account",
      #                               :type => "account_register_new",
      #                               :language => "en",
      #                               :password => @user.password,
      #                               :to => @user.email,
      #                               :username => @user.first_name}.to_json)
      # rename exp and add const '%m-%d-%Y %H:%M'
      render json: { token:, expiration_date: time.strftime(DATE_FORMAT),
                     user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    # remove 40 --43
    if user_params.key?(:email) || user_params.key?(:password)
      render json: { errors: 'You cannot update email or password' }, status: :unprocessable_entity
      return
    end
    # @user.update and add skip_validation???
    if @user.update_columns(first_name: params[:first_name], last_name: params[:last_name])
      render json: @user, status: :ok, serializer: Api::V1::UserSerializer
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    # current_user.destroy

    # destroy session
    @user.destroy

    # render json: { success: 'ok' }, status: :ok
    # else render json: { errors: }
  end

  private

  def set_user
    # TODO: need fix current_user and add here instead of User.find(params[:id])
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :github_token)
  end
end
