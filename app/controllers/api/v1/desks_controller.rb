class Api::V1::DesksController < ApplicationController
  # move to aplication controller before_action :authorize_request
  before_action :authorize_request
  before_action :desk_params, only: %i[create update]
  before_action :set_project, only: %i[index create]
  before_action :set_desk, :authorize_user, only: %i[show update destroy]
  before_action :set_desks, only: :index

  def index
    render json: @desks, status: :ok, include: [], each_serializer: Api::V1::DeskSerializer
  end

  def show
    render json: @desk, status: :ok, serializer: Api::V1::DeskSerializer
  end

  def create
    desk = @project.desks.new(desk_params)

    authorize desk

    if desk.save
      render json: desk, status: :ok, serializer: Api::V1::DeskSerializer
    else
      render json: desk.errors, status: :unprocessable_entity
    end
  end

  def update
    render json: @desk, status: :ok if @desk.update(desk_params)
  end

  def destroy
    @desk.destroy
  rescue ActiveRecord::InvalidForeignKey => e
    render json: { errors: e.message }, status: :unauthorized
  end

  private

  def authorize_user
    authorize @desk || Desk
  end

  def set_project
    @project = Project.find(params[:project_id])
  # rescue from https://apidock.com/rails/ActiveSupport/Rescuable/ClassMethods/rescue_from
  # catch errors in aplication controller
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def set_desk
    @desk = Desk.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def set_desks
    @desks = @project.desks
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def desk_params
    params.permit(:name)
  rescue ActionController::ParameterMissing => e
      # rescue from https://apidock.com/rails/ActiveSupport/Rescuable/ClassMethods/rescue_from
  # catch errors in aplication controller
    render json: { errors: e.message }, status: :bad_request
  end
end
