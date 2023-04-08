class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request
  before_action :comment_params, only: %i[create update]
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = Comment.new(comment_params)
    authorize @comment

    if @comment.save
      render json: @comment, status: :ok, serializer: CommentSerializer
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      render json: @comment, serializer: CommentSerializer
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:commentable_id, :commentable_type, :body, :task_id, :user_id)
  end
end
