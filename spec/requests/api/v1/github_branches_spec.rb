require 'rails_helper'

RSpec.describe 'api/v1/github_branches', type: :request do
  path '/api/v1/projects/{project_id}/github_branches' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    get('Project list branches') do
      tags 'Github branch'
      description 'Project list branches'
      consumes 'application/json'

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

  path '/api/v1/projects/{project_id}/github_branches/{task_id}' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    parameter name: 'task_id', in: :path, type: :string, description: 'task_id'
    get('Show task branches') do
      tags 'Github branch'
      description 'Show task branches'
      consumes 'application/json'

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

  path '/api/v1/projects/{project_id}/github_branches' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    post('Create branch') do
      tags 'Github branch'
      description 'Create branch'
      consumes 'application/json'

      parameter name: :branch, in: :body, schema: {
        type: :object,
        properties: {
          task_id: { type: :integer, default: 1 },
          branch_name: { type: :string, default: 'branch-name' },
          sha: { type: :string, example: 'Parent branch sha' }
        },
        required: %w[task_id branch_name sha]
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
