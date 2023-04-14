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
                   name: { type: :string },
                   last_name: { type: :string },
                   email: { type: :string }
                 },
                 required: %w[id name last_name email]
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
                   name: { type: :string },
                   last_name: { type: :string },
                   email: { type: :string },
                   github_token: { type: :string }
                 },
                 required: %w[id name last_name email]

          let(:id) { user.id }
          run_test!
        end

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end

    path '/api/v1/about_user' do
      get 'Retrieves information about the current user' do
        tags 'Users'
        produces 'application/json'
        parameter name: :current_user, in: :header, type: :string, description: 'JWT token to identify current user'

        response '200', 'user information found' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   last_name: { type: :string },
                   email: { type: :string }
                 },
                 required: %w[id name last_name email]

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
            name: { type: :string },
            last_name: { type: :string },
            email: { type: :string },
            password: { type: :string },
            github_token: { type: :string }
          },
          required: %w[name last_name email password]
        }

        security []

        response '200', 'user created' do
          let(:user) { build(:user) }
          run_test!
        end

        response '422', 'invalid request' do
          let(:user) { { name: 'John', last_name: 'Doe' } }
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
            name: { type: :string },
            last_name: { type: :string },
            github_token: { type: :string }
          }
        }

        response '200', 'user updated' do
          let(:user) { { name: 'New Name', github_token: 'New token' } }
          let(:id) { user_id }
          run_test!
        end

        response '422', 'invalid request' do
          let(:user) { { name: nil } }
          let(:id) { user_id }
          run_test!
        end

        response '404', 'user not found' do
          let(:id) { 'invalid' }
          let(:user) { { name: 'New Name' } }
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
                 exp: { type: :string },
                 name: { type: :string }
               },
               required: %w[token exp name]

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

  path '/api/v1/reset' do
    post 'Resets a user password' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :reset_password, in: :body, schema: {
        type: :object,
        properties: {
          old_password: { type: :string },
          password: { type: :string }
        },
        required: %w[old_password password]
      }
      security [{ bearerAuth: [] }]

      response '200', 'Password reset successfully' do
        let(:Authorization) { "Bearer #{user_token}" }
        let(:reset_password) { { old_password: user.password, password: 'new_password' } }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { '' }
        let(:reset_password) { { old_password: user.password, password: 'new_password' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:Authorization) { "Bearer #{user_token}" }
        let(:reset_password) { { old_password: user.password, password: '' } }
        run_test!
      end

      response '404', 'Invalid or expired password reset token' do
        let(:Authorization) { "Bearer #{user_token}" }
        let(:reset_password) { { old_password: 'wrong_password', password: 'new_password' } }
        run_test!
      end

      response '404', 'User not found' do
        let(:Authorization) { "Bearer #{user_token}" }
        let(:reset_password) { { old_password: user.password, password: 'new_password' } }
        before { user.destroy }
        run_test!
      end
    end
  end
end
