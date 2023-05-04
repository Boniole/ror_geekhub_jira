class Api::V1::PasswordsController < ApplicationController
  include NatsPublisher
  include TwilioSmsable
  skip_before_action :authorize_request, only: %i[reset_password forget_password]

  def forget_password
    render_error(errors: ['Email not present']) if params[:email].blank?

    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      # SEND EMAIL HERE
      nats_publish('service.mail', { class: 'account',
                                     type: 'account_reset_password',
                                     language: 'en',
                                     to: user.email,
                                     token: user.reset_password_token,
                                     username: user.first_name }.to_json)
      render_success(data: 'ok')
    else
      render_error(errors: ['Email address not found. Please check and try again'], status: :not_found)
    end
  end

  def reset_password
    render_error(errors: ['Token not present']) if params[:token].blank?

    user = User.find_by(reset_password_token: params[:token])

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render_success(data: 'ok')
      else
        render_error(errors: user.errors.full_messages)
      end
    else
      render_error(errors: ['Link not valid or expired. Try generating a new link'], status: :not_found)
    end
  end

  def update_password
    if current_user.authenticate(params[:old_password])
      if current_user.update!(password: params[:password])
        send_sms

        render_success(data: current_user, serializer: Api::V1::UserSerializer)
      else
        render_error(errors: current_user.errors.full_messages)
      end
    else
      render_error(errors: ['Old password is incorrect'])
    end
  end

  private

  def send_sms
    if current_user.phone_number.present?
      send_twilio_sms(current_user.phone_number,
                      'Your password has been successfully changed')
    end
  end
end
