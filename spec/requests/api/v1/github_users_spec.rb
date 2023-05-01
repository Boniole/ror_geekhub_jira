require 'rails_helper'

RSpec.describe 'api/v1/github_users', type: :request do
  path '/api/v1/github_users/show' do
    get('create column') do
      tags 'Github User'
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
