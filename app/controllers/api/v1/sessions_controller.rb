# app/controllers/api/v1/sessions_controller.rb

class Api::V1::SessionsController < Api::V1::ApplicationController
  # POST /api/v1/sessions
  skip_before_action :authenticate_request

  def create
    @user = User.find_by_username(user_params[:username])
    if @user
      token = jwt_encode(user_id: @user.id)
      render json: {
        message: 'User logged in successfully.',
        username: @user.username,
        token:
      }, status: :ok
    else
      render json: { message: 'User not registered.', errors: @user.errors }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:session).permit(:username)
  end
end
