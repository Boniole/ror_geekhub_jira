class Api::V1::UsersController < ApplicationController
  def create
    @user = User.create(user_params)

    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :created
    else
      render json: { error: 'Invalid name or password' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end