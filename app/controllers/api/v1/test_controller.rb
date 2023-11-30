class Api::V1::TestController < ApplicationController
  def index
    render json: { message: 'This is to test CORS and Frontend Backend communication if you R reading it. your backend is properly connected to frontend.' }
  end
end
