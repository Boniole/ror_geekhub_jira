class Api::V1::PasswordsController < ApplicationController
  include NatsPublisher
  skip_before_action :authorize_request, only: %i[update_password forget_password]

  def forget_password
    return render json: { error: 'Email not present' } if params[:email].blank?

    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      # SEND EMAIL HERE

      # concorn nats_publish nuts able
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

  def reset_password
    return render json: { error: 'Token not present' } if params[:email].blank?

    user = User.find_by(reset_password_token: params[:token])

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

  def update_password
    unless current_user.authenticate(params[:old_password])
      return render json: { error: 'Old password is incorrect' }, status: :unprocessable_entity
    end

    current_user.generate_password_token!

    return render json: { error: 'Invalid or expired password reset token' } if current_user.reset_password_token.blank?

    password = params[:password]
    if current_user.present? && current_user.password_token_valid?
      current_user.password = password
      if current_user.valid?
        current_user.reset_password!(password)
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Token not valid or expired. Try again' }, status: :not_found
    end
  end
end
