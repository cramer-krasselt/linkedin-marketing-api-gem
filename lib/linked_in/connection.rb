require 'faraday_middleware'
require 'active_support'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each { |f| require f }

module LinkedInAPI
  # @private
  module Connection
    private


      def connection(raw = false, request_connection_options = {})
        options = {
          :headers => { 'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent },
          :proxy   => proxy,
          :url     => endpoint,
        }.merge(connection_options)

        options = options.deep_merge(request_connection_options)

        Faraday::Connection.new(options) do |connection|
          connection.use LinkedInFaradayMiddleware::LinkedInAPIOAuth2, client_id, client_secret, access_token
          connection.use Faraday::Request::UrlEncoded
          connection.use FaradayMiddleware::Mashify unless raw
          unless raw
            case format.to_s.downcase
            when 'json' then
              connection.use Faraday::Response::ParseJson
            end
          end
          connection.use LinkedInFaradayMiddleware::RaiseHttpException
          connection.use LinkedInFaradayMiddleware::LoudLogger if loud_logger
          connection.adapter(adapter)
        end
      end
  end
end
