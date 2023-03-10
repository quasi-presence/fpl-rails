class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { id: user.id, email: user.email, token: token }, status: 200
    else
      render json: { errors: ['Unauthorized'] }, status: 401
    end
  end
end
