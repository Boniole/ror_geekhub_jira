class Api::V1::DesksController < ApplicationController
  before_action :authorize_request
  before_action :desk_params, only: %i[create update]
  before_action :set_desk, only: %i[show update destroy]
  before_action :set_desks, only: :index

  def index
    render json: @desks, status: :ok, include: [], each_serializer: DeskSerializer
  end

  def show
    render json: @desk, status: :ok, serializer: DeskSerializer
  end

  def create
    desk = Desk.new(desk_params)
    desk.user_id = @current_user.id

    if desk.save
      render json: desk, status: :ok, serializer: DeskSerializer
    else
      render json: desk.errors, status: :unprocessable_entity
    end
  end

  def update
    render json: @desk, status: :ok if @desk.update(desk_params)
  end

  def destroy
    @desk.destroy
  rescue ActiveRecord::InvalidForeignKey
    render json: { errors: 'You cannot delete a board while you have dependencies' }, status: :unauthorized
  end

  private

  def set_desk
    @desk = Desk.find(params[:id])
    if @desk.user_id == @current_user.id
      @desk
    else
      render json: { errors: 'User is not authorized to access this resource' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render errors.full_messages, status: :not_found
  end

  def set_desks
    project = Project.find(desk_params[:project_id])
    @desks = project.desks
  end

  def desk_params
    params.require(:desk).permit(:name, :project_id)
  rescue ActionController::ParameterMissing
    render json: { error: 'Missing required parameter(s)' }, status: :bad_request
  end
end
