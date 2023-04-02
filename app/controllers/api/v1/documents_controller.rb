require 'aws-sdk-s3'

class Api::V1::DocumentsController < ApplicationController
  # before_action :authorize_request
  before_action :document_params, only: %i[create update]
  before_action :set_attachable
  before_action :set_document, only: [:show, :destroy]

  def index
    s3 = Aws::S3::Resource.new
    @result = []
    @documents = @attachable.documents
    @documents.each.with_index do |document, index|
      document.files.blobs.each do |blob|
        obj = s3.bucket(ENV['AWS_BUCKET']).object(blob.key)
        file_name = blob.filename
        url = obj.presigned_url(:get, expires_in: 3600)
        @result << { name: file_name, url: url }
      end
    end
    render json: @result, status: :ok
  end

  def show
    s3 = Aws::S3::Resource.new
    url = []
    @document.files.blobs.each do |blob|
      obj = s3.bucket(ENV['AWS_BUCKET']).object(blob.key)
      url << { name: [blob.filename], url: obj.presigned_url(:get, expires_in: 3600) }
    end
    render json: url
  end

  def create
    @document = Document.new
    @document.documentable = @attachable
    @document.files.attach(params[:documents])
    if @document.save
      render json: {}, status: :created
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  def destroy
    s3 = Aws::S3::Client.new
    @document.files.blobs.each do |blob|
      s3.delete_object(bucket: ENV['AWS_BUCKET'], key: blob[:filename])
    end
    @document.files.purge
    @document.destroy
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
    # TODO VLAD catch errors, fix documentable_id: @attachable.id
    @document = @attachable.documents.find_by(documentable_id: @attachable.id)
    # if @document == nil
    #   render json: { errors: 'Not found files' }, status: :not_found
    # else
    #   @document
    # end
  end

  def document_params
    params.permit(documents: [])
  end
end
