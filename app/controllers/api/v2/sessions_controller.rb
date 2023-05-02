class Api::V2::SessionsController < ApplicationController
  # before_action :google_params, only: [:omniauth]

  def omniauth
    # remove from model to controller .from_omniauth(auth) or concern
    user = User.from_omniauth(auth)
    #move dot env Rails.application.secrets.secret_key_base
    token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)

    render json: { token: }
  end

# add action security session 
# 'JWT session' https://github.com/tuwukee/jwt_sessions
#https://www.javatpoint.com/ruby-on-rails-session


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
