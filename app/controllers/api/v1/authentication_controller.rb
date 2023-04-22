class Api::V1::AuthenticationController < ApplicationController
  include TokenGenerationable
  skip_before_action :authorize_request

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token_data = generate_token(@user.id)
      render json: { token: token_data[:token], expiration_date: token_data[:expiration_date],
                     user: @user }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
