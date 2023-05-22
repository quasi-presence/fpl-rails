class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      response.headers['Access-Control-Expose-Headers'] = 'Authorization'
      response.headers['Authorization'] = token
      render json: { id: user.id, email: user.email, imageUrl: user.image_url }, status: 200
    else
      render json: { errors: ['Unauthorized'] }, status: 401
    end
  end
end
