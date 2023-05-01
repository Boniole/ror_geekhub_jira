class Api::V1::ColumnsController < ApplicationController
  before_action :column_params, only: %i[create update]
  before_action :set_column, :authorize_user, only: %i[show update destroy]

  def show
    render_success(data: @column, serializer: Api::V1::ColumnSerializer)
  end

  def create
    column = Column.new(column_params)
    authorize column
    if column.save
      render_success(data: column, status: :created, serializer: Api::V1::ColumnSerializer)
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
    authorize @column || Column.find
  end

  def set_column
    @column = current_project.desks.first.columns.find(params[:id]) if current_project.present?
  end

  def column_params
    params.permit(:desk_id, :name, :ordinal_number)
  end
end
