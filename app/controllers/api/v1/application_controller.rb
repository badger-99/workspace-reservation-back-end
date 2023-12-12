class Api::V1::ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request

  private

  def authenticate_request
    puts 'authenticate_request'
    puts request.headers['Authorization']
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  end
end
