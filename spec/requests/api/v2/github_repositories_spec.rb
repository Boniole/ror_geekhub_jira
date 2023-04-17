require 'rails_helper'

RSpec.describe 'api/v2/github_users', type: :request, swagger_doc: 'v2/swagger.yaml' do
  path '/api/v2/github_users/show' do
    get('create column') do
      tags 'GithubUser'
      description 'Github User'
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


  path '/api/v2/github_repositories/create' do

    post('Create repository') do
      tags 'Github repository'
      description 'Create repository'
      consumes 'application/json'

      parameter name: :repository, in: :body, schema: {
        type: :object,
        properties: {
          project_id: { type: :integer, default: 1 },
          name: { type: :string, default: 'Name repository' },
          description: { type: :string, default: 'Name description' },
          private: { type: :boolean, example: true },
          has_issues: { type: :boolean, default: true },
          has_downloads: { type: :boolean, example: true }
        },
        required: %w[project_id name description private has_issues has_downloads]
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

  path '/api/v2/github_repositories/update' do
    patch('Update repository') do
      tags 'Github repository'
      description 'Update repository'
      consumes 'application/json'

      parameter name: :repository, in: :body, schema: {
        type: :object,
        properties: {
          project_id: { type: :integer, default: 1 },
          name: { type: :string, default: 'Name repository' },
          description: { type: :string, default: 'Name description' },
          private: { type: :boolean, example: true },
          has_issues: { type: :boolean, default: true },
          has_downloads: { type: :boolean, example: true }
        },
        required: %w[project_id name description private has_issues has_downloads]
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

  path '/api/v2/github_repositories/delete' do
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
