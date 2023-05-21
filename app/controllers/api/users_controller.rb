class Api::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    data = Api::Service.call(params['version'], 'CreateUser', user_params)
    render json: data, status: data['errors'].present? ? 422 : 200
  end

  def update
    data = Api::Service.call(params['version'], 'UpdateUser', user_params)
    render json: data, status: data['errors'].present? ? 422 : 200
  end

  private

  def user_params
    params.permit(:id, :email, :imageUrl, :password)
  end
end
