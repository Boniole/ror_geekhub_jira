require 'swagger_helper'

RSpec.describe 'api/v1/desks', type: :request do

  path '/api/v1/desks' do
    get('list desks') do
      tags 'Desks'
      description 'Get desks'
      produces 'application/json'
      parameter name: :project_id,
                in: :post,
                required: true,
                schema: {
                  type: :integer
                },
                default: 1,
                description: 'The ID of the project (integer)'
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               },
               required: %w[id name]
        run_test!
      end
    end

    post('create desk') do
      tags 'Desks'
      description 'Create desk'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :desk, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'My desk' },
          project_id: { type: :integer, default: 1 }
        },
        required: %w[name project_id]
      }
      response(201, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string },
                 user: { type: :object }
               },
               required: %w[id name status]
        run_test!
      end
    end
  end

  path '/api/v1/desks/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show desk') do
      tags 'Desks'
      description 'Get desk by id'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
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
          name: { type: :string, default: 'My desk' },
          project_id: { type: :integer, default: 1 }
        },
        required: %w[name project_id]
      }
      response(200, 'successful') do
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

    put('update desk') do
      tags 'Desks'
      description 'Update desk'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :desk, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'My desk' },
          project_id: { type: :integer, default: 1 }
        },
        required: %w[name project_id]
      }
      response(200, 'successful') do
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
