# app/controllers/api/v1/registrations_controller.rb

class Api::V1::RegistrationsController < ApplicationController
  # POST /api/v1/registrations
  def create
    request_data = JSON.parse(request.body.read)
    @user = User.new(username: request_data['username'])

    if @user.save
      render json: {status: 201, message: "User registered successfully.", user: {id: @user.id, username: @user.username, authentication_token: @user.authentication_token}}, status: :created
    else
      render json: {status: 400, message: "User not registered.", errors: @user.errors}, status: :bad_request
    end
  end
end

# How to use this controller:
#
# 1. Make a POST request to http://localhost:3000/api/v1/registrations with a JSON body containing the username of the user you want to create.
# 2. If the user is created successfully, you will receive a JSON response with a status code of 201 and a message of "User registered successfully.".
# 3. If the user is not created successfully, you will receive a JSON response with a status code of 400 and a message of "User not registered.".


# How to effectively communicate with this controller:
#
# Your React component for user registration
# const handleRegistration = async (username) => {
#   try {
#     const response = await fetch('http://localhost:3000/registrations', {
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
#     console.error('An error occurred during registration:', error);
#   }
# };