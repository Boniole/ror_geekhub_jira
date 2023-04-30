require 'rails_helper'

RSpec.describe 'api/v1/github_users', type: :request do
  path '/api/v1/projects/{project_id}/github_repositories/create' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    post('Create repository') do
      tags 'Github repository'
      description 'Create repository'
      consumes 'application/json'

      parameter name: :repository, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'Name repository' },
          description: { type: :string, default: 'Name description' },
          private: { type: :boolean, example: true },
          has_issues: { type: :boolean, default: true },
          has_downloads: { type: :boolean, example: true }
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

  path '/api/v1/projects/{project_id}/github_repositories/update' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    patch('Update repository') do
      tags 'Github repository'
      description 'Update repository'
      consumes 'application/json'

      parameter name: :repository, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'Name repository' },
          description: { type: :string, default: 'Name description' },
          private: { type: :boolean, example: true },
          has_issues: { type: :boolean, default: true },
          has_downloads: { type: :boolean, example: true }
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

  path '/api/v1/projects/{project_id}/github_repositories/delete' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'
    delete('delete repository') do
      tags 'Github repository'
      description 'Delete repository'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :repository, in: :body, schema: {
        type: :object,
        properties: {
          project_id: { type: :integer, default: 1 },
          validate_text: { type: :string, default: 'owner/repo_name' }
        },
        required: %w[project_id validate_text]
      }

      response(204, 'successful') do
        run_test!
      end
    end
  end
end
