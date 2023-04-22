class Api::V1::ColumnsController < ApplicationController
  before_action :column_params, only: %i[create update]
  before_action :set_column, :authorize_user, only: %i[show update destroy]

  def show
    render_success(data: @column, serializer: Api::V1::ColumnSerializer)
  end

  def create
    column = Column.new(column_params)
    authorize column

    column.ordinal_number = Desk.find_by(id: column_params[:desk_id]).columns.count + 1 

    if column.save
      render_success(data: @column, status: :created, serializer: Api::V1::ColumnSerializer)
    else
      render_error(errors: column.errors)
    end
  end

  def update
    if @column.update(column_params)
      render_success(data: @column, serializer: Api::V1::ColumnSerializer)
    else
      render_error(errors: @column.errors)
    end
  end

  def destroy
    @column.destroy
  end

  private

  def authorize_user
    authorize @column || Column
  end

  def set_column
    @column = Column.find(params[:id])
  end

  def column_params
    params.permit(:desk_id, :name, :ordinal_number)
  end
end
