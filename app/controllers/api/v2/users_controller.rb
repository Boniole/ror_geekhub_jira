class Api::V2::UsersController < ApplicationController
  include NatsPublisher

  before_action :authorize_request, except: :create
  before_action :set_user, except: %i[create index about_current_user]

  def index
    @users = User.all
    render json: @users, status: :ok, include: [], each_serializer: Api::V2::UserSerializer
  end

  def show
    render json: @user, status: :ok, serializer: Api::V2::UserSerializer
  end

  def about_current_user
    render json: current_user, status: :ok, serializer: Api::V2::UserSerializer
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      nats_publish('service.mail', {:class => "account",
                                    :type => "account_register_new",
                                    :language => "en",
                                    :password => @user.password,
                                    :to => @user.email,
                                    :username => @user.first_name}.to_json)
      render json: { token:, expiration_date: time.strftime('%m-%d-%Y %H:%M'),
                     user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if user_params.key?(:email) || user_params.key?(:password)
      render json: { errors: 'You cannot update email or password' }, status: :unprocessable_entity
      return
    end

    if @user.update_columns(first_name: params[:first_name], last_name: params[:last_name])
      render json: @user, status: :ok, serializer: Api::V2::UserSerializer
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :github_token)
  end
end
