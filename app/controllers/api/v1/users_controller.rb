class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :set_user, except: %i[create index about_current_user]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok, include: [], each_serializer: UserSerializer
  end

  # GET /users/user_id
  def show
    render json: @user, status: :ok, serializer: UserSerializer
  end

  def about_current_user
    render json: @current_user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
debugger
      client = Octokit::Client.new(:access_token => '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')
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                     name: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/user_id
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/user_id
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
