require 'rails_helper'

RSpec.describe 'Api::V1::Passwords', type: :request do
  path '/api/v1/forget_password' do
    post 'Generates a password reset token and sends an email' do
      tags 'Password'
      consumes 'application/json'
      parameter name: :email, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        },
        required: %w[email]
      }

      security []

      response '200', 'Password reset token sent successfully' do
        let(:email) { { email: 'user@example.com' } }
        run_test!
      end

      response '404', 'Email address not found' do
        let(:email) { { email: 'nonexistent_user@example.com' } }
        run_test!
      end
    end
  end

  path '/api/v1/reset_password' do
    post 'Resets a user password with a valid password reset token' do
      tags 'Password'
      consumes 'application/json'
      parameter name: :reset_password, in: :body, schema: {
        type: :object,
        properties: {
          token: { type: :string },
          password: { type: :string }
        },
        required: %w[token password]
      }

      security []

      response '200', 'Password reset successfully' do
        let(:reset_password) { { token: 'valid_token', password: 'new_password' } }
        run_test!
      end

      response '422', 'Invalid password reset request' do
        let(:reset_password) { { token: 'valid_token', password: '' } }
        run_test!
      end

      response '404', 'Invalid or expired password reset token' do
        let(:reset_password) { { token: 'invalid_token', password: 'new_password' } }
        run_test!
      end
    end
  end

  path '/api/v1/update_password' do
    patch 'Updates user password' do
      tags 'Password'
      consumes 'application/json'
      parameter name: :password_params, in: :body, schema: {
        type: :object,
        properties: {
          old_password: { type: :string },
          password: { type: :string }
        },
        required: %w[old_password password]
      }

      response '200', 'Password updated successfully' do
        let(:current_user) { create(:user) }
        let(:old_password) { current_user.password }
        let(:password) { 'new_password' }
        run_test!
      end

      response '422', 'Validation failed' do
        let(:current_user) { create(:user) }
        let(:old_password) { current_user.password }
        let(:password) { '' }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:current_user) { create(:user) }
        let(:old_password) { 'wrong_password' }
        let(:password) { 'new_password' }
        run_test!
      end
    end
  end
end
