class Api::V2::CommentsController < ApplicationController
  before_action :authorize_request
  before_action :comment_params, only: %i[create update]
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    # current_user.comments.new

    authorize @comment

    if @comment.save
      render json: @comment, status: :ok, serializer: Api::V2::CommentSerializer
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      render json: @comment, serializer: Api::V2::CommentSerializer
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
    @comment = Comment.current_comment(current_user, params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end
