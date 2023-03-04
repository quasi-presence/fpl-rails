class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    token_data = decode_token(header)
    @current_user = User.find(token_data[:user_id])
  end

  def encode_token(token_data, expires: 1.day.from_now)
    token_data[:exp] = expires.to_i
    JWT.encode(token_data, Rails.application.secret_key_base)
  end

  def decode_token(token)
    token_data = JWT.decode(token, Rails.application.secret_key_base)
    HashWithIndifferentAccess.new(token_data[0])
  end
end
