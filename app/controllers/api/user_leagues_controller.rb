class Api::UserLeaguesController < ApplicationController
  def create
    data = Api::Service.call(params['version'], 'CreateUserLeague', user_league_params)
    render json: data, status: data['errors'].present? ? 422 : 200
  end

  private

  def user_league_params
    params.permit(:id, :name, :imageUrl).merge({ owner_id: @current_user.id })
  end
end
