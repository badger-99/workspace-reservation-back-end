require 'rails_helper'

RSpec.describe 'Api::V1::WorkspacesControllers', type: :request do
  before do
    post '/api/v1/registrations', params: {
      registration: {
        username: 'workspace_user'
      }
    }
    post '/api/v1/sessions', params: {
      session: {
        username: 'workspace_user'
      }
    }
    session = JSON.parse(response.body).deep_symbolize_keys
    @token = session[:token]
  end

  describe 'GET /index' do
    it 'returns an array of workspaces' do
      get '/api/v1/workspaces'
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(response.status).to eq(200)
      expect(json[:workspaces]).to be_a(Array)
    end
  end

  describe 'GET /show' do
    context 'request for an existing workspace' do
      it 'returns a single workspace' do
        image = fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg')
        workspace = Workspace.create(name: 'workspace', description: 'for respec testing', image:)
        get "/api/v1/workspaces/#{workspace.id}", headers: { Authorization: "Bearer #{@token}" }

        json = JSON.parse(response.body).deep_symbolize_keys
        url = json[:workspace][:image_url]
        expect(response.status).to eq(200)
        expect(json[:workspace][:name]).to eq('workspace')
        expect(json[:workspace][:description]).to eq('for respec testing')
        expect(URI.parse(url)).to be_a(URI::HTTP)
        expect { URI.parse(url) }.not_to raise_error
      end
    end
    context 'request for a non-existent workspace' do
      it 'returns an error' do
        id = 1138
        get "/api/v1/workspaces/#{id}", headers: { Authorization: "Bearer #{@token}" }

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'POST /create' do
    context 'creating a workspace with the correct parameters' do
      it 'creates a workspace' do
        image = fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg')
        post '/api/v1/workspaces', params: {
          workspace: {
            name: 'test_workspace',
            description: 'workspace to test the create endpoint',
            image:
          }
        }, headers: { Authorization: "Bearer #{@token}" }

        json = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(201)
        expect(json[:success]).to eq('Workspace has been created.')
        expect(json[:workspace][:name]).to eq('test_workspace')
        expect(json[:workspace][:description]).to eq('workspace to test the create endpoint')
      end
    end

    context 'creating a workspace with the wrong parameters' do
      it 'returns an error message' do
        post '/api/v1/workspaces', params: {
          workspace: {
            name: '',
            description: ''
          }
        }, headers: { Authorization: "Bearer #{@token}" }

        json = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(400)
        expect(json[:error]).to eq('workspace has not been created.')
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'a delete request for an existing workspace' do
      it 'deletes a workspace' do
        image = fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg')
        workspace = Workspace.create(name: 'workspace', description: 'for respec testing', image:)
        delete "/api/v1/workspaces/#{workspace.id}", headers: { Authorization: "Bearer #{@token}" }

        json = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(200)
        expect(json[:success]).to eq('workspace deleted')
      end
    end

    context 'a delete request for an non-existent workspace' do
      it 'returns an error message' do
        image = fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg')
        workspace = Workspace.create(name: 'workspace', description: 'for respec testing', image:)
        Workspace.destroy(workspace.id)
        delete "/api/v1/workspaces/#{workspace.id}", headers: { Authorization: "Bearer #{@token}" }

        expect(response.status).to eq(404)
      end
    end
  end
end
