class Api::V2::SessionsController < ApplicationController

  def omniauth
    user = User.from_omniauth(auth)
    token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)

    render json: { token: }
  end


  def auth
    request.env['omniauth.auth']
  end
end
