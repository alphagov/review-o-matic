require 'net/http'

class MigratoratorApi
  class Client

    def initialize(base_uri, logger = nil)
      @base_uri = base_uri
      @logger = logger || NullLogger.instance
    end

    def get(partial_uri)
      do_request Net::HTTP::Get, partial_uri
    end

    protected

    def do_request(method, partial_uri, params = {})
      uri = URI.parse(@base_uri + '/api' + partial_uri)
      request = method.new(uri.path + ( uri.query.blank? ? '' : "?#{uri.query}") )
      request.form_data = params
      @logger.debug "#{method::METHOD}: #{uri} #{params.inspect}"
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https' ) do |http|
        http.request(request)
      end
    end
  end
end
