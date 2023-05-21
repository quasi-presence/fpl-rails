class Api::V1::UpdateUser
  class << self
    def call(params)
      user = User.find_by(id: params['id'])
      return { 'errors' => ['Not found'] } if user.blank?

      user.update(update_params(params)) ? service_data(user) : error_data(user)
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

    def update_params(params)
      {}.tap do |hash|
        hash[:email] = params['email']
        hash[:image_url] = params['imageUrl']
        hash[:password] = params['password'] if params['password'].present?
      end
    end
  end
end
