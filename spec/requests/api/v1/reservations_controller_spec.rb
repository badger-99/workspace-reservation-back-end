require 'rails_helper'

RSpec.describe 'Api::V1::ReservationsControllers', type: :request do
  before do
    post '/api/v1/registrations', params: {
      registration: {
        username: 'workspace_user'
      }
    }
    registration = JSON.parse(response.body).deep_symbolize_keys
    @current_user_id = registration[:user][:id]
    post '/api/v1/sessions', params: {
      session: {
        username: 'workspace_user'
      }
    }
    session = JSON.parse(response.body).deep_symbolize_keys
    @current_user = session[:token]
  end

  describe 'GET /index' do
    it 'returns an array of reservations made by the current user' do
      get '/api/v1/reservations', headers: { Authorization: "Bearer #{@current_user}" }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(response.status).to eq(200)
      expect(json[:reservations]).to be_a(Array)
    end
  end

  describe 'GET /show' do
    context 'a valid request' do
      it 'shows a specific reservation made by the current user' do
        image = fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg')
        workspace = Workspace.create(name: 'workspace', description: 'for respec testing', image:)
        city = 'Tokyo'
        start_date = Date.new(2024, 12, 1)
        end_date = Date.new(2024, 12, 1)
        user_id = @current_user_id
        workspace_id = workspace.id
        reservation = Reservation.create(city:, start_date:, end_date:, user_id:, workspace_id:)
        get "/api/v1/reservations/#{reservation.id}", headers: { Authorization: "Bearer #{@current_user}" }

        json = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(200)
        expect(json[:reservation][:city]).to eq('Tokyo')
        expect(json[:reservation][:start_date]).to eq('2024-12-01')
        expect(json[:reservation][:end_date]).to eq('2024-12-01')
        expect(json[:reservation][:user_id]).to eq(@current_user_id)
        expect(json[:reservation][:workspace_id]).to eq(workspace.id)
      end
    end

    context 'an invalid request' do
      it 'returns an error message' do
        id = 1138
        get "/api/v1/reservations/#{id}", headers: { Authorization: "Bearer #{@current_user}" }

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'POST /create' do
    context 'creating a reservation with valid parameters' do
      it 'creates a reservation' do
        image = fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg')
        workspace = Workspace.create(name: 'workspace', description: 'for respec testing', image:)
        post '/api/v1/reservations', params: {
          workspace: workspace.id,
          reservation: {
            start_date: '2024-10-10',
            end_date: '2024-10-12',
            city: 'Copenhagen'
          }
        }, headers: { Authorization: "Bearer #{@current_user}" }

        json = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(201)
        expect(json[:success]).to eq('Reservation has been created.')
        expect(json[:reservation][:city]).to eq('Copenhagen')
        expect(json[:reservation][:start_date]).to eq('2024-10-10')
        expect(json[:reservation][:end_date]).to eq('2024-10-12')
        expect(json[:reservation][:workspace_id]).to eq(workspace.id)
      end
    end

    context 'creating a reservation with invalid parameters' do
      it 'returns an error' do
        image = fixture_file_upload('app/assets/images/pizza meme.jpg', 'image/jpg')
        workspace = Workspace.create(name: 'workspace', description: 'for respec testing', image:)
        post '/api/v1/reservations', params: {
          workspace: workspace.id,
          reservation: {
            start_date: '',
            end_date: '',
            city: ''
          }
        }, headers: { Authorization: "Bearer #{@current_user}" }

        expect(response.status).to eq(400)
      end
    end

    context 'creating a reservation without a workspace id' do
      it 'returns satus 404' do
        post '/api/v1/reservations', params: {
          workspace: '',
          reservation: {
            start_date: '2024-10-10',
            end_date: '2024-10-12',
            city: 'Copenhagen'
          }
        }, headers: { Authorization: "Bearer #{@current_user}" }

        expect(response.status).to eq(404)
      end
    end
  end
end
