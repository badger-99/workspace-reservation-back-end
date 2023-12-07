require 'swagger_helper'

RSpec.describe 'api/v1/registrations', type: :request do
  describe 'POST /api/v1/registrations' do
    path '/api/v1/registrations' do
      post 'Registers a new user' do
        tags 'Users'
        consumes 'application/json'
        produces 'application/json'

        parameter name: :registration, in: :body, description: 'Username needed to create a new user.', schema: {
          type: :object,
          properties: {
            username: { type: :string }
          },
          required: ['username']
        }

        response '201', 'user registered successfully' do
          schema type: :object,
                 properties: {
                   message: { type: :string },
                   user: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       username: { type: :string }
                     },
                     required: %w[id username]
                   }
                 }

          let(:registration) { { username: 'test_user' } }

          run_test!
        end

        response '400', 'user not registered' do
          schema type: :object,
                 properties: {
                   status: { type: :integer },
                   message: { type: :string },
                   errors: {
                     type: :object,
                     properties: {
                       username: { type: :array, items: { type: :string } }
                     }
                   }
                 }

          let(:registration) { { username: '' } }

          run_test!
        end
      end
    end
  end
end
