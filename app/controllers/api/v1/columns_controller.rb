class Api::V1::ColumnsController < ApplicationController
  before_action :column_params, only: %i[create update]
  before_action :set_column, only: %i[update destroy]
  before_action :set_columns, only: %i[index]

  def index
    render json: @columns
  end

  def create
    @column = Column.new(column_params)

    if @column.save
      render json: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  def update
    if @column.update(column_params)
      render json: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @column.destroy
  end

  private

  def set_column
    @column = Column.find(params[:id])
  end

  def set_columns
    @columns = Column.all
  end

  def column_params
    params.require(:column).permit(:columnable_id, :columnable_type, :name, :desk_id)
  end
end
