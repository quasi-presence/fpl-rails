class Api::V1::CreateUserLeague
  class << self
    def call(params)
      user_league = UserLeague.new(create_params(params))
      user_league.save ? service_data(user_league) : error_data(user_league)
    end

    private

    def service_data(user_league)
      {
        'id' => user_league.id,
        'name' => user_league.name,
        'imageUrl' => user_league.image_url
      }
    end

    def error_data(user_league)
      { 'errors' => user_league.errors.full_messages }
    end

    def create_params(params)
      {}.tap do |hash|
        hash[:owner_id] = params['owner_id']
        hash[:name] = params['name']
        hash[:image_url] = params['imageUrl']
      end
    end
  end
end
