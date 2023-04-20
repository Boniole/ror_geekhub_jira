require 'swagger_helper'

RSpec.describe 'api/v1/tasks', type: :request do
  path '/api/v1/tasks' do

    post('create task') do
      tags 'Tasks'
      description 'Create task'
      consumes "application/json"

      parameter(
        name: :project_id,
        in: :post,
        required: true,
        schema: {
          type: :integer
        },
        default: 1,
        description: 'The ID of the project (integer)'
      )

      parameter(
        name: :assignee_id,
        in: :post,
        required: false,
        schema: {
          type: :integer
        },
        default: 1,
        description: 'The ID of the assignee (integer)'
      )

      parameter(
        name: :desk_id,
        in: :post,
        required: true,
        schema: {
          type: :integer
        },
        default: 1,
        description: 'The ID of the desk (integer)'
      )

      parameter(
        name: :column_id,
        in: :post,
        required: true,
        schema: {
          type: :integer
        },
        default: 1,
        description: 'The ID of the desk (integer)'
      )

      parameter(
        name: :name,
        in: :post,
        required: true,
        schema: {
          type: :string
        },
        default: 'Task name',
        description: 'The name of the task (string)'
      )

      parameter(
        name: :description,
        in: :post,
        required: false,
        schema: {
          type: :string,
        },
        default: 'Task description',
        description: 'The description of the task (optional)'
      )

      parameter(
        name: :priority_number,
        in: :post,
        required: false,
        schema: {
          type: :string
        },
        default: '1',
        description: 'sort number'
      )

      parameter(
        name: :estimate,
        in: :post,
        required: false,
        schema: {
          type: :string
        },
        default: '2w',
        description: 'The estimated time for completion (e.g. 2w, 4d, 6h, 45m) (optional)'
      )

      parameter(
        name: :label,
        in: :post,
        required: false,
        schema: {
          type: :string
        },
        default: 'task',
        description: 'The label of the task (optional)'
      )

      parameter(
        name: :start_date,
        in: :post,
        required: false,
        schema: {
          type: :string,
          format: 'date'
        },
        default: '2023-12-12',
        description: 'The start date of the task (date in YYYY-MM-DD format) (optional)'
      )

      parameter(
        name: :end_date,
        in: :post,
        required: false,
        schema: {
          type: :string,
          format: 'date'
        },
        default: '2023-12-12',
        description: 'The end date of the task (date in YYYY-MM-DD format) (optional)'
      )

      parameter(
        name: :priority,
        in: :post,
        required: false,
        schema: {
          type: :string,
          enum: %w[lowest low high highest]
        },
        default: 'lowest',
        description: 'Task priority: lowest/low/high/highest.'
      )

      parameter(
        name: :type_of,
        in: :post,
        required: false,
        schema: {
          type: :string,
          enum: %w[task bug epic]
        },
        default: 'task',
        description: 'Task type: task/bug/epic.'
      )

      parameter(
        name: :status,
        in: :post,
        required: false,
        schema: {
          type: :string,
          enum: %w[open close]
        },
        default: 'open',
        description: 'Task status: open/close.'
      )
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          assignee_id: { type: :integer, default: 1 },
          column_id: { type: :integer, default: 1 },
          desk_id: { type: :integer, default: 1 },
          project_id: { type: :integer, default: 1 },
          name: { type: :string },
          description: { type: :string },
          priority_number: { type: :integer, default: 1 },
          estimate: { type: :string },
          label: { type: :string },
          priority: { type: :integer },
          start_date: { type: :string },
          end_date: { type: :string },
          status: { type: :integer },
          type_of: { type: :integer }
        },
        required: %w[name column_id desk_id project_id]
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

  path '/api/v1/tasks/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show task') do
      tags 'Tasks'
      description 'Get task by id'
      consumes "application/json"
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

    patch('update task') do
      tags 'Tasks'
      description 'Update task'
      consumes "application/json"

      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          assignee_id: { type: :integer, default: 1 },
          column_id: { type: :integer, default: 1 },
          desk_id: { type: :integer, default: 1 },
          project_id: { type: :integer, default: 1 },
          name: { type: :string },
          description: { type: :string },
          priority_number: { type: :integer, default: 1 },
          estimate: { type: :string },
          label: { type: :string },
          priority: { type: :integer },
          start_date: { type: :string },
          end_date: { type: :string },
          status: { type: :integer },
          type_of: { type: :integer }
        },
        required: %w[name column_id desk_id project_id]
      }
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

    delete('delete task') do
      tags 'Tasks'
      description 'Delete task'
      consumes "application/json"
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
  end
end
