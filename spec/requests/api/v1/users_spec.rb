require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users' do
    post('create user') do
      tags 'Users'
      description 'Create a new user'
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
          properties: {
            name: { type: :string },
            password: { type: :string }
          }
          }
        },
        required: %w[user],
      }
      response '201', 'User created' do
        example 'application/json', :create_new_user, {
          user: {
            name: "Jovani Giorgio",
            password: 'password2023'}
        }
        let(:user) { { name: 'Jovani Giorgio', password: 'password2023' } }
        run_test!
      end
      response '422', 'Unprocessable Entity' do
        example 'application/json', :create_new_user_without_name, {
          user: {
            password: 'password2023'}
        }
        example 'application/json', :create_new_user_without_password, {
          user: {
            name: 'Jola'}
        }
        let(:user) { { password: 'password2023' } }
        run_test!
      end
    end
  end

  path '/api/v1/login' do

    post('login user') do
      tags 'Users'
      description 'Login as user'
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: %w[user],
      }

      response '200', 'Success' do
        example 'application/json', :create_new_user, {
          user: {
            name: "Jovani Giorgio",
            password: 'password2023'}
        }
        let(:user) { { name: 'Jovani Giorgio', password: 'password2023' } }
        run_test!
      end
      response '400', 'Bad request' do
        example 'application/json', :create_new_user_without_name, {
          user: {
            password: 'password2023'}
        }
        example 'application/json', :create_new_user_without_password, {
          user: {
            name: 'Jola'}
        }
        let(:user) { { password: 'password2023' } }
        run_test!
      end
    end
  end
end
