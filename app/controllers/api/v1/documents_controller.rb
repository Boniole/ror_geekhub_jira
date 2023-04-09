class Api::V1::DocumentsController < ApplicationController
  before_action :authorize_request
  before_action :document_params, only: %i[create update]
  before_action :set_attachable
  before_action :set_document, only: [:show, :destroy]
  before_action :set_documents, only: :index

  def index
    render json: @documents, status: :ok
  end

  def show
    render json: @document, status: :ok
  end

  def create
    saved_documents = []
    failed_documents = []
    params[:documents].each do |document|
      @document = Document.new
      @document.documentable = @attachable
      # @document.user_id = 1
      @document.user_id = @current_user.id
      @document.file.attach(document)
      @document.name = @document.file.blob.filename
      @document.document_type = @document.file.content_type.split('/').last
      @document.url = @document.file.url
      if @document.save
        saved_documents << @document
      else
        failed_documents << { document: document, errors: @document.errors }
      end
    end

    if failed_documents.any?
      render json: { saved_documents: saved_documents, failed_documents: failed_documents }, status: :multi_status
    else
      render json: { saved_documents: saved_documents }, status: :created
    end
  end

  def destroy
    if @document.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def set_attachable
    case
    when params[:project_id]
      @attachable = Project.find(params[:project_id])
    when params[:user_id]
      @attachable = User.find(params[:user_id])
    when params[:task_id]
      @attachable = Task.find(params[:task_id])
    when params[:comment_id]
      @attachable = Comment.find(params[:comment_id])
    else
      render json: { errors: 'Attachable not found' }, status: :not_found
    end
  end

  def set_document
    @document = @attachable.documents.find_by(id: params[:id])
    if @document == nil
      render json: { errors: 'Not found files' }, status: :not_found
    else
      @document
    end
  end

  def set_documents
    @documents = @attachable.documents
    if @documents == nil
      render json: { errors: 'Not found files' }, status: :not_found
    else
      @documents
    end
  end

  def document_params
    params.permit(documents: [])
  end
end
