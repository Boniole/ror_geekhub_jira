require 'swagger_helper'

RSpec.describe 'api/v1/columns', type: :request do
  path '/api/v1/columns' do
    get('list columns') do
      tags 'Columns'

      response(200, 'successful') do
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

    post('create column') do
      tags 'Columns'
      description 'Create task'
      consumes 'application/json'

      parameter name: :column, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'To do' },
          desk_id: { type: :integer, default: 1 }
        },
        required: %w[name desk_id]
      }

      response(200, 'successful') do
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

  path '/api/v1/columns/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show column') do
      tags 'Columns'

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

    patch('update column') do
      tags 'Columns'

      description 'update task'
      consumes 'application/json'

      parameter name: :column, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'To do' },
          desk_id: { type: :integer, default: 1 },
          ordinal_number: { type: :integer, default: 1 }
        },
        required: %w[name desk_id ordinal_number]
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

    delete('delete column') do
      tags 'Columns'
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
