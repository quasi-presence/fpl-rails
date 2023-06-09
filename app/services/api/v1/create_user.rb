class Api::V1::CreateUser
  class << self
    def call(params)
      user = User.new(params)
      user.save ? service_data(user) : error_data(user)
    end

    private

    def service_data(user)
      {
        'id' => user.id,
        'email' => user.email,
        'imageUrl' => user.image_url
      }
    end

    def error_data(user)
      { 'errors' => user.errors.full_messages }
    end
  end
end
