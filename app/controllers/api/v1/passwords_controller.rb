class Api::V1::PasswordsController < ApplicationController
  before_action :authorize_request, only: :reset_in_settings

  def forgot
    return render json: { error: 'Email not present' } if params[:email].blank?

    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      # SEND EMAIL HERE
      render json: { status: 'ok' }, status: :ok
    else
      render json: { error: ['Email address not found. Please check and try again.'] }, status: :not_found
    end
  end

  def reset
    token = params[:token].to_s

    return render json: { error: 'Token not present' } if params[:email].blank?

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
    user = @current_user
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
