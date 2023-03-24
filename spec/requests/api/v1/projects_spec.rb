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
                   status: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
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
        project: {
          type: :object,
          properties: {
            name: { type: :string },
            status: { type: :string },
            user_id: { type: :string },
          }}
        },
        required: %w[name status user_id]
      }
      response(201, 'successful') do
        schema type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   status: { type: :string },
                   user: { type: :object},
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id name status]
        run_test!
      end
    end
  end

  path '/api/v1/projects/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show project') do
      tags 'Projects'
      description 'Get project'
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        let(:id) { '123' }

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

    patch('update project') do
      tags 'Projects'
      description 'Update project'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          project: {
            type: :object,
            properties: {
              name: { type: :string },
              status: { type: :string },
              user_id: { type: :string },
            }}
        },
        required: %w[name status user_id]
      }
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string },
                 user: { type: :object},
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id name status user]
        run_test!
      end
    end

    put('update project') do
      tags 'Projects'
      description 'Update project'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :project, in: :body, schema: {
        type: :object,
        properties: {
          project: {
            type: :object,
            properties: {
              name: { type: :string },
              status: { type: :string },
              user_id: { type: :string },
            }}
        },
        required: %w[name status user_id]
      }
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 status: { type: :string },
                 user: { type: :object},
                 created_at: { type: :string },
                 updated_at: { type: :string }
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
end
