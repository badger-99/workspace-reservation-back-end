# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins [
      'http://localhost:3000',
      'https://zilola-nazarova.github.io/workspace-reservation-front-end',
      'https://workspace-reservation-q154.onrender.com/'
      ]

    resource '/api/v1/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end
