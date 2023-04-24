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
end
