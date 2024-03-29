class ApplicationController < ActionController::API
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  before_action :authorize_request


  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

      @decoded = JsonWebToken.decode(header)
      current_user
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
  end

  private

  def current_user
    User.find(@decoded[:user_id]) if @decoded.present?
  end

  def current_project(project_id = params[:project_id])
    current_user.memberships.find_by(project_id: project_id)&.project
  end

  def user_not_authorized
    render json: { errors: 'You do not have permission to perform this action' }, status: :forbidden
  end

  def handle_parameter_missing
    render json: { errors: "Required parameter is missing: #{exception.param}" }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    render json: { error: "#{exception.model} not found!" }, status: :not_found
  end

  def render_success(data: nil, status: :ok, serializer: nil, each_serializer: nil)
    if data.nil?
      render json: {}, status: status
    elsif data.respond_to?(:to_ary)
      render json: data, status: status, each_serializer: each_serializer
    else
      render json: data, status:, serializer: serializer
    end
  end

  def render_error(errors: [], status: :unprocessable_entity)
    render json: { errors: }, status:
  end
end
