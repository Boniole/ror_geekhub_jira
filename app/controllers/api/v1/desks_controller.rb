class Api::V1::DesksController < ApplicationController
  before_action :authorize_request
  before_action :desk_params, only: %i[create update]
  before_action :set_desk, only: %i[show update destroy]
  before_action :set_desks, only: :index

  def index
    render json: @desks, status: :ok
  end

  def show
    render json: @desk, status: :ok
  end

  def create
    desk = Desk.create(desk_params)

    if desk.save
      render json: desk, status: :created
    else
      render json: desk.errors, status: :unprocessable_entity
    end
  end

  def update
    render json: @desk, status: :ok if @desk.update(desk_params)
  end

  def destroy
    render json: @desk, status: :ok if @desk.destroy
  end

  private

  def set_desk
    @desk = Desk.find(params[:id])
  end

  def set_desks
    @desks = Desk.all
  end

  def desk_params
    params.require(:desk).permit(:name, :project_id)
  end
end
