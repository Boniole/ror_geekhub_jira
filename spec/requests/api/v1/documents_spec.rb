require 'swagger_helper'

RSpec.describe 'api/v1/documents', type: :request do

  path '/api/v1/projects/{project_id}/documents' do
    # You'll want to customize the parameter types...
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'

    get('list documents') do
      tags 'Documents'
      description 'Get documents for project'
      produces 'application/json'
      response(200, 'successful') do
        let(:project_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create document') do
      tags 'Documents'
      description 'Create document for project'
      produces 'application/json'
      consumes 'multipart/form-data'
      parameter name: :documents, in: :formData, type: :array, required: true, description: 'Array of files', schema: {
        type: 'object',
        properties: {
          'documents[]': {
            type: 'array',
            items: {
              type: 'file',
              format: 'binary'
            }
          }
        }
      }

      response(200, 'successful') do
        let(:project_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/projects/{project_id}/documents/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    parameter name: :id, in: :path, type: :integer, description: 'id'

    get('show document') do
      tags 'Documents'
      description 'Get document for project'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        let(:project_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete document') do
      tags 'Documents'
      description 'Delete document for project'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        let(:project_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/tasks/{task_id}/documents' do
    # You'll want to customize the parameter types...
    parameter name: 'task_id', in: :path, type: :integer, description: 'task_id'

    get('list documents') do
      tags 'Documents'
      description 'Get documents for task'
      consumes 'application/json'
      response(200, 'successful') do
        let(:task_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create document') do
      tags 'Documents'
      description 'Create document for task'
      produces 'application/json'
      consumes 'multipart/form-data'
      parameter name: :documents, in: :formData, type: :array, required: true, description: 'Array of files', schema: {
        type: 'object',
        properties: {
          'documents[]': {
            type: 'array',
            items: {
              type: 'file',
              format: 'binary'
            }
          }
        }
      }
      response(200, 'successful') do
        let(:task_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/tasks/{task_id}/documents/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :task_id, in: :path, type: :integer, description: 'task_id'
    parameter name: :id, in: :path, type: :integer, description: 'id'

    get('show document') do
      tags 'Documents'
      description 'Show document for task'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        let(:task_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete document') do
      tags 'Documents'
      description 'Dekete document for task'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        let(:task_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/comments/{comment_id}/documents' do
    # You'll want to customize the parameter types...
    parameter name: :comment_id, in: :path, type: :integer, description: 'comment_id'

    get('list documents') do
      tags 'Documents'
      description 'Get documents for comment'
      produces 'application/json'
      parameter name: 'documents[]', in: :formData, type: :file, required: true, description: 'Array of files', schema: {
        type: 'object',
        properties: {
          documents: {
            type: 'array',
            items: {
              type: 'string',
              format: 'binary'
            }
          }
        }
      }
      response(200, 'successful') do
        let(:comment_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create document') do
      tags 'Documents'
      description 'Create document for comment'
      produces 'application/json'
      consumes 'multipart/form-data'
      parameter name: :documents, in: :formData, type: :array, required: true, description: 'Array of files', schema: {
        type: 'object',
        properties: {
          'documents[]': {
            type: 'array',
            items: {
              type: 'file',
              format: 'binary'
            }
          }
        }
      }

      response(200, 'successful') do
        let(:comment_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/comments/{comment_id}/documents/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :comment_id, in: :path, type: :integer, description: 'comment_id'
    parameter name: :id, in: :path, type: :integer, description: 'id'

    get('show document') do
      tags 'Documents'
      description 'Get documents for comment'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        let(:comment_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete document') do
      tags 'Documents'
      description 'Delete documents for comment'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        let(:comment_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
