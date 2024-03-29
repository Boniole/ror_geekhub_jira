class Api::V1::DesksController < ApplicationController
  before_action :authorize_request
  before_action :desk_params, only: %i[create update]
  before_action :set_desk, only: %i[show update destroy]
  before_action :set_desks, only: :index

  def index
    render_success(data: @desks, each_serializer: Api::V1::DeskSerializer)
  end

  def show
    render_success(data: @desk, serializer: Api::V1::DeskSerializer)
  end

  def create
    desk = @project.desks.new(desk_params)

    if desk.save
      render_success(data: desk, status: :created, serializer: Api::V1::DeskSerializer)
    else
      render_error(errors: desk.errors)
    end
  end

  def update
    return render_success(data: @desk, serializer: Api::V1::DeskSerializer) if @desk.update(desk_params)

    render_error(errors: @desk.errors)
  end

  def destroy
    @desk.destroy
  end

  private

  def set_desk
    @desk = current_project.desks.find(params[:id])
  end

  def set_desks
    @desks = current_project.desks
  end

  def desk_params
    params.permit(:name)
  end
end
