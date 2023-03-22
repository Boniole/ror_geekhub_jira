class Api::V1::TasksController < ApplicationController
  before_action :task_params, only: %i[create update]
  before_action :set_task, only: %i[show update destroy]
  before_action :set_tasks, only: %i[index]

  def index
    render json: @tasks, status: :ok, include: [], each_serializer: TaskSerializer
  end

  def show
    render json: @task, status: :ok, serializer: TaskSerializer
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, serializer: TaskSerializer
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_tasks
    @tasks = Task.all
  end

  def task_params
    params.require(:task).permit(
      :project_id,
      :user_id,
      :desk_id,
      :column_id,
      :column_type,
      :title,
      :description,
      :estimate,
      :label,
      :priority,
      :type_of,
      :status,
      :start,
      :end
    )
  end
end
