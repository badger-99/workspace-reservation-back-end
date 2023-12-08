require 'swagger_helper'
require 'base64'

RSpec.describe 'api/v1/workspaces', type: :request do
  path '/api/v1/workspaces' do # rubocop:disable Metrics/BlockLength
    get 'Retrieves all workspaces' do
      tags 'Workspaces'
      produces 'application/json'

      response '200', 'successful' do
        schema type: :object,
               properties: {
                 workspaces: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       description: { type: :string },
                       image_url: { type: :string }
                     },
                     required: %w[id name description]
                   }
                 }
               }

        run_test!
      end
    end

    post 'Creates a new workspace' do
      security 'bearerAuth'
      tags 'Workspaces'
      consumes 'multipart/form-data'
      produces 'application/json'

      # parameter name: :workspace, in: :body, schema: {
      #   type: :object,
      #   properties: {
      #     workspace[name] => { type: :string },
      #     workspace[description] => { type: :string },
      #     workspace[image] => { type: :string, format: :binary }
      #   },
      #   required: %w[name description image]
      # }

      response '201', 'workspace created successfully' do
        schema type: :object,
               properties: {
                 success: { type: :string }
               }

        let(:image) do
          {
            data: File.read('app/assets/images/pizza meme.jpg', mode: 'rb'),
            filename: 'pizza meme.jpg',
            type: 'image/jpg'
          }
        end
        let(:workspace) do
          {
            workspace[name] => 'test_user',
            workspace[description] => 'Some descriptors here.',
            workspace[image] => :image
          }
        end
        run_test!
      end

      response '400', 'workspace not created' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        let(:workspace) { { name: '', description: '' } }

        run_test!
      end
    end
  end

  path '/api/v1/workspaces/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'Workspace ID'

    get 'Retrieves a specific workspace' do
      tags 'Workspaces'
      produces 'application/json'

      response '200', 'successful' do
        schema type: :object,
               properties: {
                 workspace: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     description: { type: :string },
                     image_url: { type: :string } # Adjust based on your requirements
                   },
                   required: %w[id name description]
                 }
               }

        run_test!
      end
    end

    delete 'Deletes a workspace' do
      security 'bearerAuth'
      tags 'Workspaces'
      produces 'application/json'

      response '201', 'workspace deleted' do
        schema type: :object,
               properties: {
                 success: { type: :string }
               }

        let(:id) { create(:workspace).id }

        run_test!
      end

      response '400', 'something went wrong' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        let(:id) { 'nonexistent_id' }

        run_test!
      end
    end
  end
end

# before(:each) do
#   # @user = User.create('s0m3b0di3')
#   # @token = jwt_encode(user_id: @user.id)
#   # let(:Authorization) { "Bearer #{@token}" } # Include authentication token if needed
#   # let(:user_id) { user.id }
#   # header 'Authorization', "Bearer #{@token}"
# end
              # consumes 'multipart/form-data'
              # request_body content: {
              #   'application/json' => {
              #     schema: {
              #       type: :object,
              #       properties: {
              #         name: { type: :string },
              #         description: { type: :string },
              #         image: { type: :string, format: :binary }
              #       },
              #       required: %w[name description image]
              #     }
              #   }
              # }
