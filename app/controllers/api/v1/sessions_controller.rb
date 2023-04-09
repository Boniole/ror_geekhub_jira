class Api::V1::SessionsController < ApplicationController
  # before_action :google_params, only: [:omniauth]

  def omniauth
    user = User.from_omniauth(auth)
    token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)

    render json: { token: }
  end

  def auth
    request.env['omniauth.auth']
  end

  # private

  # def google_params
  #   params.permit(:token)
  # end

  # def auth
  #   request.env['action_dispatch.request.request_parameters']['auth']
  # end
end
