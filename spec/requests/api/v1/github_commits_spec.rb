require 'rails_helper'

RSpec.describe 'api/v1/github_commits', type: :request do

  path '/api/v1/projects/{project_id}/github_commits/{task_id}' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    parameter name: 'task_id', in: :path, type: :string, description: 'task_id'
    parameter name: 'sha', in: :path, type: :string, description: 'Branch sha'
    get('Show branch commits') do
      tags 'Github commit'
      description 'Show branch commits'
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
end
