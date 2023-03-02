class Api::UsersController < ApplicationController
  def create
    data = Api::Service.call(params['version'], 'CreateUser', user_params)
    render json: data, status: data['errors'].present? ? 422 : 200
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
