class Api::V1::AuthenticationController < ApplicationController
  include TokenGenerationable
  skip_before_action :authorize_request

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token_data = generate_token(@user.id)
      render_success(data: {
                       token: token_data[:token],
                       expiration_date: token_data[:expiration_date],
                       user: @user
                     })
    else
      render_error(errors: ['Unauthorized'], status: :unauthorized)
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
