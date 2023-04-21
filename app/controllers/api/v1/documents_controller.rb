class Api::V1::DocumentsController < ApplicationController
  before_action :document_params, only: %i[create update]
  before_action :set_attachable
  before_action :set_document, :authorize_user, only: [:show, :destroy]
  before_action :set_documents, only: :index

  def index
    render_success(data: @documents)
  end

  def show
    render_success(data: @documents)
  end

  def create
    saved_documents = []
    failed_documents = []
#authorize @document move before creating new documents

    params[:documents].each do |document|
      @document = Document.new
      @document.documentable = @attachable
          # current_user.document.new
      @document.user_id = @current_user.id
      @document.file.attach(document)
      @document.name = @document.file.blob.filename
      @document.document_type = @document.file.content_type.split('/').last
      @document.url = @document.file.url

      authorize @document

      if @document.save
        saved_documents << @document
      else
        failed_documents << { document: document, errors: @document.errors }
      end
    end

    if failed_documents.any?
      # check status?
      # add serialized documents?
      render json: { saved_documents: saved_documents, failed_documents: failed_documents }, status: :multi_status
    else
      render json: { saved_documents: saved_documents }, status: :created
    end
  end


  def destroy
    @document.destroy
  end

  private

  def authorize_user
    authorize @document || Document
  end

  def set_attachable
    case
    when params[:project_id]
      # current user not models Project...
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
    @document = @attachable.documents.find(id: params[:id])
  end

  def set_documents
    @documents = @attachable.documents
  end

  def document_params
    params.permit(documents: [])
  end
end
