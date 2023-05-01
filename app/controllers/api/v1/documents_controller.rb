class Api::V1::DocumentsController < ApplicationController
  before_action :document_params, only: %i[create update]
  before_action :authorize_user, :set_attachable
  before_action :set_document, :authorize_user, only: [:show, :destroy]
  before_action :set_documents, only: :index

  def index
    render_success(data: @documents, each_serializer: Api::V1::DocumentSerializer)
  end

  def show
    render_success(data: @document, each_serializer: Api::V1::DocumentSerializer)
  end

  def create
    saved_documents = []
    failed_documents = []

    params[:documents].each do |document|
      @document = current_user.documents.new
      @document.documentable = @attachable
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
      render_success( data: { saved_documents: saved_documents, failed_documents: failed_documents },
                      status: :multi_status,
                      each_serializer: Api::V1::DocumentSerializer)
    else
      render_success(data: saved_documents, status: :created)
    end
  end

  def destroy
    @document.destroy
  end

  private

  def authorize_user
    authorize @document || Document.find
  end

  def set_attachable
    case
    when params[:project_id]
      @attachable = current_user.projects.find(params[:project_id])
    when params[:task_id]
      @attachable = current_user.tasks.find(params[:task_id])
    when params[:comment_id]
      @attachable = Comment.current_comment(current_user, params[:comment_id])
    else
      render_error(errors: 'Attachable not found', status: :not_found)
    end
  end

  def set_document
    @document = @attachable.documents.find(params[:id])
  end

  def set_documents
    @documents = @attachable.documents
  end

  def document_params
    params.permit(documents: [])
  end
end
