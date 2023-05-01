require 'rails_helper'

RSpec.describe 'api/v1/github_pullrequests', type: :request do
  path '/api/v1/projects/{project_id}/github_pullrequests' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    post('Create pullrequest') do
      tags 'Github pullrequest'
      description 'Create pullrequest'
      consumes 'application/json'

      parameter name: :pullrequest, in: :body, schema: {
        type: :object,
        properties: {
          task_id: { type: :integer, default: 1 },
          base_name: { type: :string, default: 'main' },
          head_name: { type: :string, default: 'dev' },
          title: { type: :string, default: 'Title pullrequest' },
          body: { type: :string, default: 'Body pullrequest' }
        },
        required: %w[name description private has_issues has_downloads]
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

