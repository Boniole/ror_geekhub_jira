class Api::V1::ColumnsController < ApplicationControll:error
  before_action :set_column, only: %i[show update destroy]
  before_action :set_columns, only: %i[index]

  def index
    render json: @columns
  end

  def show
    render json: @column
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

  def task_params
    params.require(:column).permit(:name, :desk_id)
  end
end
