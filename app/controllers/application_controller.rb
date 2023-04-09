class ApplicationController < ActionController::API
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # helper_method :nats_publish

  def not_found
    render json: { error: 'not_found' }
  end

  attr_reader :current_user

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private

  def user_not_authorized
    render json: { error: 'You do not have permission to perform this action' }, status: :forbidden
  end


  # def nats_publish(subject, data)
  #   require 'nats/client'
  #   require 'json'
  #
  #   nats = NATS.connect(ENV['NATS_SERVER_PORT'])
  #   nats.publish(subject, data)
  # end
end
