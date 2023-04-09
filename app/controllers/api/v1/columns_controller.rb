class Api::V1::ColumnsController < ApplicationController
  before_action :authorize_request
  before_action :column_params, only: %i[create update]
  before_action :set_column, only: %i[show update destroy]

  def show
    authorize @column
    render json: @column, status: :ok, serializer: ColumnSerializer
  end

  def create
    @column = Column.new(column_params)
    authorize @column
    @column.ordinal_number = Desk.find_by(id: column_params[:desk_id]).columns.count + 1

    if @column.save
      render json: @column, status: :ok, serializer: ColumnSerializer
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @column
    if @column.update(column_params)
      render json: @column, status: :ok, serializer: ColumnSerializer
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @column
    @column.destroy
  end

  private

  def set_column
    @column = Column.find(params[:id])
  end

  def column_params
    params.permit(:desk_id, :name, :ordinal_number)
  end
end
