class Api::V1::TasksController < ApplicationController
  before_action :authorize_request
  before_action :task_params, only: %i[create update]
  before_action :set_task, only: %i[show update destroy]
  before_action :set_tasks, only: %i[index]

  def index
    render json: @tasks, status: :ok, include: [], each_serializer: TaskSerializer
  end

  def show
    # authorize @task
    render json: @task, status: :ok, serializer: TaskSerializer
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = @current_user.id
    # authorize @task

    if @task.save
      render json: @task, status: :created, serializer: TaskSerializer
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    # authorize @task

    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # authorize @task
    @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Task not found' }, status: :not_found
  end

  def set_tasks
    @tasks = Task.all
  end

  def task_params
    params.require(:task).permit(
      :project_id,
      :user_id,
      :assignee_id,
      :desk_id,
      :column_id,
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
