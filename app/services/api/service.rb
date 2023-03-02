class Api::Service
  class << self
    def call(version, service_name, params)
      service = "Api::#{version.upcase}::#{service_name}".constantize
      service.call(params)
    rescue NameError => ex
      { 'errors' => ["API #{version} does not support #{service_name.titleize.downcase}"] }
    end
  end
end
