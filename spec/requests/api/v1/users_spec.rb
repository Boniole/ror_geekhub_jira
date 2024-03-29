require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }

  path '/api/v1/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'Users found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   first_name: { type: :string },
                   last_name: { type: :string },
                   email: { type: :string }
                 },
                 required: %w[id first_name last_name email]
               }
        run_test!
      end
    end

    path '/api/v1/users/{id}' do
      get 'Retrieves a user' do
        tags 'Users'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer

        response '200', 'user found' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   first_name: { type: :string },
                   last_name: { type: :string },
                   email: { type: :string },
                   github_token: { type: :string }
                 },
                 required: %w[id first_name last_name email]

          let(:id) { user.id }
          run_test!
        end

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end

    path '/api/v1/my_profile' do
      get 'Retrieves information about the current user' do
        tags 'Users'
        produces 'application/json'

        response '200', 'user information found' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   first_name: { type: :string },
                   last_name: { type: :string },
                   email: { type: :string }
                 },
                 required: %w[id first_name last_name email]

          let(:current_user) { 'Bearer ' + JsonWebToken.encode(user_id: user.id) }
          run_test!
        end

        response '401', 'unauthorized access' do
          let(:current_user) { '' }
          run_test!
        end
      end
    end

    path '/api/v1/users' do
      post 'Creates a user' do
        tags 'Users'
        consumes 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            first_name: { type: :string },
            last_name: { type: :string },
            email: { type: :string },
            password: { type: :string },
            github_token: { type: :string },
            phone_number: { type: :string }
          },
          required: %w[first_name last_name email password]
        }

        security []

        response '200', 'user created' do
          let(:user) { build(:user) }
          run_test!
        end

        response '422', 'invalid request' do
          let(:user) { { first_name: 'John', last_name: 'Doe' } }
          run_test!
        end
      end
    end

    path '/api/v1/users/{id}' do
      patch 'Updates a user' do
        tags 'Users'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :integer
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            first_name: { type: :string },
            last_name: { type: :string },
            github_token: { type: :string }
          }
        }

        response '200', 'user updated' do
          let(:user) { { first_name: 'New Name', github_token: 'New token' } }
          let(:id) { user_id }
          run_test!
        end

        response '422', 'invalid request' do
          let(:user) { { first_name: nil } }
          let(:id) { user_id }
          run_test!
        end

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          let(:user) { { first_name: 'New Name' } }
          run_test!
        end
      end

      delete 'Deletes a user' do
        tags 'Users'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :integer

        response '204', 'user deleted' do
          let(:id) { user_id }
          run_test!
        end

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
  end

  path '/api/v1/login' do
    post 'Logs in a user' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :login, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      security []

      response '200', 'logged in successfully' do
        schema type: :object,
               properties: {
                 token: { type: :string },
                 expiration_date: { type: :string },
                 first_name: { type: :string }
               },
               required: %w[token expiration_date first_name]

        let(:user) { create(:user) }
        let(:login) { { email: user.email, password: user.password } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:login) { { email: 'invalid_email@example.com', password: 'invalid_password' } }
        run_test!
      end
    end
  end
end
