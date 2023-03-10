class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy]
  before_action :set_tasks, only: %i[index]

  def index
    render json: @tasks
  end

  def show
    render json: @task
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task
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
    params.require(:task).permit(:title, :description, :status, :type, :project_id, :user_id)
  end
end
