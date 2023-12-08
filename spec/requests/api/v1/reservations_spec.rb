require 'swagger_helper'
require 'base64'

RSpec.describe 'api/v1/reservations', type: :request do
  path '/api/v1/reservations' do # rubocop:disable Metrics/BlockLength
    get 'Retrieves all reservations for the current user' do
      security 'bearerAuth'
      tags 'Reservations'
      produces 'application/json'

      response '200', 'successful' do
        run_test!
      end
    end

    post 'Creates a new reservation' do # rubocop:disable Metrics/BlockLength
      security 'bearerAuth'
      tags 'Reservations'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          start_date: { type: :date, format: 'date' },
          end_date: { type: :date, format: 'date' },
          city: { type: :string },
          workspace_id: { type: :integer }, # Adjust based on your requirements
          user_id: {type: :integer}
        },
        required: %w[start_date end_date city workspace]
      }

      response '200', 'successful' do
        schema type: :object,
               properties: {
                 reservation: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     start_date: { type: :date, format: 'date' },
                     end_date: { type: :date, format: 'date' },
                     city: { type: :string },
                     workspace_id: { type: :integer },
                     user_id: { type: :integer }
                   },
                   required: %w[id start_date end_date city workspace_id user_id]
                 },
                 success: { type: :string }
               }

        let(:name) { 'test_user' }
        let(:description) { 'Some descriptors here.' }
        let(:image) do
          {
            data: Base64.strict_encode64(File.read('app/assets/images/pizza meme.jpg')),
            filename: 'pizza meme.jpg',
            type: 'image/jpg'
          }
        end
        let(:workspace) { Workspace.create(name:, description:, image:) }
        let(:user) { User.create(username: 'some_dude') }
        let(:reservation) do
          {
            start_date: '2023-01-01',
            end_date: '2023-01-05',
            city: 'Sample City',
            workspace_id: workspace.id,
            user_id: user.id
          }
        end
        run_test!
      end
      response '400', 'reservation not created' do
        schema type: :object,
               properties: {
                 errors: { type: :array, items: { type: :string } }
               }

        let(:reservation) { { start_date: '', end_date: '', city: '', workspace: '' } }

        run_test!
      end
    end
  end

  path '/api/v1/reservations/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'Reservation ID'

    get 'Retrieves a specific reservation' do
      security 'bearerAuth'
      tags 'Reservations'
      produces 'application/json'

      response '200', 'successful' do
        schema type: :object,
               properties: {
                 reservation: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     start_date: { type: :string, format: 'date' },
                     end_date: { type: :string, format: 'date' },
                     city: { type: :string },
                     workspace_id: { type: :integer },
                     user_id: { type: :integer }
                   },
                   required: %w[id start_date end_date city workspace_id user_id]
                 }
               }

        run_test!
      end
    end
  end
end
