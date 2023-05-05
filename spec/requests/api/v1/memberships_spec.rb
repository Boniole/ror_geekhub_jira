require 'swagger_helper'

RSpec.describe 'api/v1/memberships', type: :request do

  path '/api/v1/projects/{project_id}/memberships' do
    parameter name: 'project_id', in: :path, type: :integer, description: 'project_id'

    post('create membership') do
      tags 'Memberships'
      description 'Create membership'
      consumes 'application/json'

      parameter name: :membership, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
        },
        required: %w[email]
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

    delete('delete membership') do
      tags 'Memberships'
      description 'Delete membership'
      consumes 'application/json'

      parameter name: :membership, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
        },
        required: %w[email]
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
end
