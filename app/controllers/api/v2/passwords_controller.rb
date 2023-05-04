class Api::V2::PasswordsController < ApplicationController
  include NatsPublisher
  include Passwordable
  before_action :authorize_request, only: :reset_in_settings
  def forgot
    return render json: { errors: 'Email not present' } if params[:email].blank?

    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      nats_publish('service.mail', { class: 'account',
                                     type: 'account_reset_password',
                                     language: 'en',
                                     to: user.email,
                                     token: user.reset_password_token,
                                     username: user.first_name }.to_json)
      render json: { status: 'ok' }, status: :ok
    else
      render json: { error: ['Email address not found. Please check and try again.'] }, status: :not_found
    end
  end

  def reset
    token = params[:token]

    debugger
    return render json: { error: 'Token not present' } if params[:token].blank?

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: ['Link not valid or expired. Try generating a new link.'] }, status: :not_found
    end
  end

  def reset_in_settings
    user = current_user
    old_password = params[:old_password]
    password = params[:password]

    unless user.authenticate(old_password)
      return render json: { error: 'Old password is incorrect' }, status: :unprocessable_entity
    end

    user.generate_password_token!

    return render json: { error: 'Invalid or expired password reset token' } if user.reset_password_token.blank?

    if user.present? && user.password_token_valid?
      user.password = params[:password]
      if user.valid?
        user.reset_password!(params[:password])
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Token not valid or expired. Try again' }, status: :not_found
    end
  end
end
