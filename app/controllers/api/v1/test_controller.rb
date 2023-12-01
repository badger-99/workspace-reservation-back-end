class Api::V1::TestController < ApplicationController
  def index
    render json: { message: 'This is to test CORS and Frontend Backend communication. Blessing on you!!!' }
  end
end

# TestController is a controller that is used to test the connection
# between the frontend and the backend. It is not used in the final product.
