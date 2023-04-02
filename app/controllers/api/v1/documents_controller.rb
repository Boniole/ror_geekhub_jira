class Api::V1::DocumentsController < ApplicationController
  before_action :authorize_request
  before_action :set_attachable, only: %i[index create]
  before_action :set_document, only: %i[show update destroy]

  def index
    @documents = @attachable.documents
    render json: @documents
  end

  def show
    authorize @document
    render json: @document
  end

  def create
    @document = @attachable.documents.new(document_params)
    @document.user_id = @current_user
    authorize @document

    if @document.save
      render json: @document, status: :created
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @document

    if @document.update(document_params)
      render json: @document
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @document

    @document.destroy
    head :no_content
  end

  private

  def set_attachable
    if params[:project_id]
      @attachable = Project.find(params[:project_id])
    elsif params[:user_id]
      @attachable = User.find(params[:user_id])
    elsif params[:task_id]
      @attachable = Task.find(params[:task_id])
    elsif params[:comment_id]
      @attachable = Comment.find(params[:comment_id])
    elsif params[:tag_id]
      @attachable = Tag.find(params[:tag_id])
    else
      render json: { error: 'Attachable not found' }, status: :not_found
    end
  end

  def set_document
    @document = document.find(params[:id])
  end

  def document_params
    params.permit(documents: [])
  end
end
