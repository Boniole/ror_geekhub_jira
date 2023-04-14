require 'swagger_helper'

RSpec.describe 'api/v1/desks', type: :request do

  path '/api/v1/projects/{project_id}/desks' do
    # You'll want to customize the parameter types...
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'

    get('list desks') do
      tags 'Desks'
      description 'Get desks'
      produces 'application/json'
      consumes 'application/json'
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

    post('create desk') do
      tags 'Desks'
      description 'Create desks'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :desk, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name]
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

  path '/api/v1/projects/{project_id}/desks/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    parameter name: :id, in: :path, type: :integer, description: 'desk_id'

    get('show desk') do
      tags 'Desks'
      description 'Get desk'
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

    patch('update desk') do
      tags 'Desks'
      description 'Update desk'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :desk, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name]
      }
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

    delete('delete desk') do
      tags 'Desks'
      description 'Delete desk'
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
end
