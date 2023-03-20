class Api::V1::CommentsController < ApplicationController
  before_action :comment_params, only: %i[create update]
  before_action :set_comment, only: %i[update destroy]
  before_action :set_comments, only: %i[index]

  def index
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_comments
    @comments = Comment.all
  end

  def comment_params
    params.require(:comment).permit(:body, :task_id, :user_id)
  end
end
