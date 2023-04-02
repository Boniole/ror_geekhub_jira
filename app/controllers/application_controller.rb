class ApplicationController < ActionController::API
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def not_found
    render json: { error: 'not_found' }
  end

  attr_reader :current_user, :github_user

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

  def authorize_github
    @github_client = Octokit::Client.new(access_token: @current_user.github_token, auto_paginate: true)
  rescue Octokit::BadRequest
    render json: { errors: 'Github token invalid or empty!' }, status: :not_found
  end

  private

  def user_not_authorized
    render json: { error: 'You do not have permission to perform this action' }, status: :unauthorized
  end
end
