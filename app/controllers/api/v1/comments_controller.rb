class Api::V1::CommentsController < ApplicationController
  before_action :comment_params, only: %i[create update]
  before_action :set_comment, :authorize_user, only: %i[update destroy]

  def create
    comment = current_user.comments.new(comment_params)

    authorize comment

    if comment.save
      render_success(data: comment, status: :created, serializer: Api::V1::CommentSerializer)
    else
      render_error(errors: comment.errors)
    end
  end

  def update
    if @comment.update(comment_params)
      render_success(data: @comment, serializer: Api::V1::CommentSerializer)
    else
      render_error(errors: @comment.errors)
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
    @comment = Comment.current_comment(current_user, params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end
