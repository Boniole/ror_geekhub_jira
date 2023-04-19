class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request
  before_action :comment_params, only: %i[create update]
  before_action :set_comment, :authorize_user, only: %i[update destroy]

  def create
    @comment = Comment.new(comment_params)

    authorize @comment

    @comment.user_id = current_user.id
    # current_user.comments.new

    if @comment.save
      render json: @comment, status: :ok, serializer: Api::V1::CommentSerializer
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, serializer: Api::V1::CommentSerializer
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def authorize_user
    authorize @comment || Comment
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end
