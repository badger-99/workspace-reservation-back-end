# app/controllers/api/v1/sessions_controller.rb

class Api::V1::SessionsController < ApplicationController
  # POST /api/v1/sessions
  def create
    request_data = JSON.parse(request.body.read)
    @user = User.find_by(username: request_data['username'])

    if @user
      render json: {status: 200, message: "User logged in successfully.", user: {id: @user.id, username: @user.username, authentication_token: @user.authentication_token}}, status: :ok
    else
      render json: {status: 404, message: "User not found."}, status: :not_found
    end
  end
end

# How to use this controller:
#
# 1. Make a POST request to http://localhost:3000/api/v1/sessions with a JSON body containing the username of the user you want to log in.
# 2. If the user is found, you will receive a JSON response with a status code of 200 and a message of "User logged in successfully.".
# 3. If the user is not found, you will receive a JSON response with a status code of 404 and a message of "User not found.".


# How to effectively communicate with this controller:
#
# Your React component for user login
# const handleLogin = async (username) => {
#   try {
#     const response = await fetch('http://localhost:3000/sessions', {
#       method: 'POST',
#       headers: {
#         'Content-Type': 'application/json',
#       },
#       body: JSON.stringify({ username }),
#     });

#     if (response.ok) {
#       const data = await response.json();
#       console.log(data); // Check the response for success
#     } else {
#       const errorData = await response.json();
#       console.error(errorData); // Check the response for errors
#     }
#   } catch (error) {
#     console.error('An error occurred during login:', error);
#   }
# };

