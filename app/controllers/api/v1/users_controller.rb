class Api::V1::UsersController < ApplicationController
  include NatsPublisher

  before_action :authorize_request, except: :create
  before_action :set_user, except: %i[create index about_current_user]

  def index
    @users = User.all
    render json: @users, status: :ok, include: [], each_serializer: UserSerializer
  end

  def show
    render json: @user, status: :ok, serializer: UserSerializer
  end

  def about_current_user
    render json: @current_user, status: :ok, serializer: UserSerializer
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
                                    :username => @user.name}.to_json)
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                     name: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:name, :last_name, :email, :password, :github_token)
  end
end
