class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @users, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    render json: { error: @user.errors.full_messages }, status: :unprocessable_entity unless @user.update(user_params)
  end

  def destroy
    @user.destroy
  end

  # def login
  #   @user = User.find_by(name: user_params[:name])

  #   if @user && @user.authenticate(user_params[:password])
  #     token = encode_token({ user_id: @user.id })
  #     render json: { user: @user, token: token }, status: :ok
  #   else
  #     render json: { error: 'Invalid name or password' }, status: :unprocessable_entity
  #   end
  # end

  private

  def user_params
    params.permit(:name, :last_name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
