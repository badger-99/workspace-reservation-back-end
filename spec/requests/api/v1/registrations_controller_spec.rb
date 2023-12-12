require 'rails_helper'

RSpec.describe 'Api::V1::RegistrationsControllers', type: :request do
  describe 'POST /create' do
    context 'when user registration is successfull' do
      it 'creates a new user' do
        post '/api/v1/registrations', params: {
          registration: {
            username: 'rspec_user'
          }
        }
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(201)
        expect(json[:message]).to eq('User registered successfully.')
        expect(json[:user][:username]).to eq('rspec_user')
      end
    end
    context 'when user registration fails' do
      it 'returns an error message' do
        post '/api/v1/registrations', params: {
          registration: {
            username: ''
          }
        }
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(response.status).to eq(400)
        expect(json[:message]).to eq('User not registered.')
        expect(json[:errors][:username]).to include("can't be blank")
      end
    end
  end
end
