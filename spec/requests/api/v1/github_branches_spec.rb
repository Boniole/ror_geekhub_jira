require 'rails_helper'

RSpec.describe 'api/v1/github_branches', type: :request do

  path '/api/v1/github_branches/index' do
    put('list branches') do
      tags 'Github branch'
      description 'List branches'
      consumes 'application/json'
      parameter name: :branch, in: :body, schema: {
        type: :object,
        properties: {
          project_id: { type: :integer, default: 1 }
        },
        required: %w[project_id]
      }

      response(200, 'successful') do
        let(:branch) { { project_id: 1 } }
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

  path '/api/v1/github_branches/create' do
    post('Create branch') do
      tags 'Github branch'
      description 'Create branch'
      consumes 'application/json'

      parameter name: :branch, in: :body, schema: {
        type: :object,
        properties: {
          project_id: { type: :integer, default: 1 },
          task_id: { type: :integer, default: 1 },
          branch_name: { type: :string, default: 'branch-name' },
          sha: { type: :string, example: 'Parent branch sha' }
        },
        required: %w[project_id task_id branch_name sha]
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
end
