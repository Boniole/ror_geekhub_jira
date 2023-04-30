class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorize_request

  def omniauth
    user = User.from_omniauth(auth)
    # move dot env Rails.application.secrets.secret_key_base
    token = JWT.encode({ user_id: user.id }, ENV['SECRET_KEY_BASE'])

    render_success(data: token)
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth[:provider], uid: auth[:uid]) do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.first_name = auth[:info][:first_name]
      user.last_name = auth[:info][:last_name]
      user.email = auth[:info][:email]
      user.password = SecureRandom.hex(15)
    end
  end

  def auth
    request.env['omniauth.auth']
  end
end
