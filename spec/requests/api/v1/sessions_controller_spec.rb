require 'rails_helper'

RSpec.describe 'Api::V1::SessionsControllers', type: :request do
  before do
    post '/api/v1/registrations', params: {
      registration: {
        username: 'login_tester'
      }
    }
  end
  describe 'POST /create' do
    context 'successfull user login' do
      it 'logs a user in' do
        post '/api/v1/sessions', params: {
          session: {
            username: 'login_tester'
          }
        }
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(200)
        expect(json[:message]).to eq('User logged in successfully.')
        expect(json[:username]).to eq('login_tester')
        expect(json[:token]).to be_present
      end
    end
    context 'failed user login' do
      it 'returns an error message' do
        post '/api/v1/sessions', params: {
          session: {
            username: 'login_user'
          }
        }
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(401)
        expect(json[:message]).to eq('User not found.')
      end
    end
  end
end
