require 'swagger_helper'

RSpec.describe 'api/v1/projects', type: :request do
  path '/api/v1/projects' do
    get('list projects') do
      tags 'Projects'
      description 'Get a list of all projects that exist in the system for the authorized user.'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 user: { type: :object,
                         properties: {
                           id: { type: :integer },
                           name: { type: :string },
                           last_name: { type: :string },
                           email: { type: :string }
                         } },
               }
        run_test!
      end
    end

    post('create project') do
      tags 'Projects'
      description 'Create a project. To create a project, you need to pass a name and user_id. The default status is open.'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          status: { type: :string, default: :open }
        },
        required: %w[name status]
      }
      response(201, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 user: { type: :object,
                         properties: {
                           id: { type: :integer },
                           name: { type: :string },
                           last_name: { type: :string },
                           email: { type: :string }
                         } },
               }
        run_test!
      end
    end
  end

  path '/api/v1/projects/{id}' do
    parameter name: 'project_id', in: :path, type: :integer, description: 'id'

    get('show project') do
      tags 'Projects'
      description 'Show the selected project to an authorized user. The required parameter is the project_id.'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               }
        run_test!
      end
    end

    patch('update project') do
      tags 'Projects'
      description 'Update the selected project of an authorized user. The required parameters are the project Id and the parameter you want to update: status, name.'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          status: { type: :string, default: :open },
          user_id: { type: :integer }
        },
        required: %w[name status user_id]
      }
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string },
                 user: { type: :object },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               }
        run_test!
      end
    end

    delete('delete project') do
      tags 'Projects'
      description 'Deleting a project by an unauthorized user. The required parameter is project_id'
      produces 'application/json'
      consumes 'application/json'
      response(204, 'successful') do
        run_test!
      end
    end
  end

  path '/api/v1/projects/{project_id}/add_member' do
    post('add member to project') do
      tags 'Projects'
      description 'Add member to project'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'project_id', in: :path, type: :integer, description: 'project_id'
      parameter name: :user_id, type: :integer, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer }
        },
        required: %w[user_id]
      }
      response(201, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user: { type: :object },
                 role: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id user role]
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

  path '/api/v1/projects/{project_id}/members/{user_id}' do
    delete('delete member from project') do
      tags 'Projects'
      description 'Delete member from project'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'project_id', in: :path, type: :integer, description: 'project_id'
      parameter name: 'user_id', in: :path, type: :integer, description: 'user_id'
      response(204, 'successful') do
        run_test!
      end
    end
  end
end
