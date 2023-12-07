require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do
  describe 'POST /api/v1/sessions' do
    path '/api/v1/sessions' do
      post 'Logs a user in' do
        tags 'Users'
        consumes 'application/json'
        produces 'application/json'

        parameter name: :session, in: :body, description: 'A username of an existing user needed to sign in.', schema: {
          type: :object,
          properties: {
            username: { type: :string }
          },
          required: ['username']
        }

        response '200', 'user logged in successfully' do
          schema type: :object,
                 properties: {
                   message: { type: :string },
                   username: { type: :string },
                   token: { type: :string }
                 }

          let(:user) { create(:user, username: 'test_user') }
          let(:username) { 'test_user' }
          let(:session) { { username: } }

          run_test!
        end

        response '401', 'user not registered' do
          schema type: :object,
                 properties: {
                   message: { type: :string },
                   errors: {
                     type: :object,
                     properties: {
                       username: { type: :array, items: { type: :string } }
                     }
                   }
                 }

          let(:session) { { username: 'nonexistent_user' } }

          run_test!
        end
      end
    end
  end
end
