require 'swagger_helper'

RSpec.describe 'api/v1/projects', type: :request do
  path '/api/v1/projects' do
    get('list projects') do
      tags 'Projects'
      description 'Get projects'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   status: { type: :string, default: :open },
                   user: { type: :object },
                   git_url: { type: :string }
                 },
                 required: %w[id name status]
               }
        run_test!
      end
    end

    post('create project') do
      tags 'Projects'
      description 'Create projects'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          status: { type: :string, default: :open }
        },
        required: %w[name]
      }
      response(201, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string, default: :open },
                 user: { type: :object },
                 git_url: { type: :string }
               },
               required: %w[id name status]
        run_test!
      end
    end
  end

  path '/api/v1/projects/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'project_id'

    get('show project') do
      tags 'Projects'
      description 'Get project'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string, default: :open },
                 user: { type: :object },
                 git_url: { type: :string }
               },
               required: %w[id name status]
        run_test!
      end
    end

    patch('update project') do
      tags 'Projects'
      description 'Update project'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          status: { type: :string, default: :open },
          user_id: { type: :integer },
          git_url: { type: :string }
        },
        required: %w[name status user_id]
      }
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string, default: :open },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 user: { type: :object },
                 git_url: { type: :string }
               },
               required: %w[id name status user]
        run_test!
      end
    end

    delete('delete project') do
      tags 'Projects'
      description 'Delete project'
      produces 'application/json'
      consumes 'application/json'
      response(204, 'successful') do
        run_test!
      end
    end
  end

  path '/api/v1/projects/{project_id}/add_member' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'

    post('add member to project') do
      tags 'Projects'
      description 'Add member to project'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        },
        required: %w[email]
      }

      response(201, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 project_id: { type: :integer },
                 role: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id email role created_at updated_at]
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: %w[error]
        run_test!
      end
    end
  end

  path '/api/v1/projects/{project_id}/delete_member' do
    parameter name: :project_id, in: :path, type: :integer, description: 'project_id'

    delete('delete member from project') do
      tags 'Projects'
      description 'Delete member from project'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :email, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        },
        required: %w[email]
      }
      response(204, 'successful') do
        run_test!
      end
    end
  end
end
