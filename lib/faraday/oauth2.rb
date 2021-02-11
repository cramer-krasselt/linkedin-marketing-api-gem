require 'faraday'
require 'base64'

# @private
module LinkedInFaradayMiddleware
  # @private
  class LinkedInAPIOAuth2 < Faraday::Middleware
    def call(env)

      if env[:method] == :get or env[:method] == :delete
        if env[:url].query.nil?
          query = {}
        else
          query = Faraday::Utils.parse_query(env[:url].query)
        end

        if @access_token and not query["client_secret"]
          env[:request_headers] = env[:request_headers].merge('Authorization' => "Bearer #{@access_token}")
        end
      else
        if @access_token and not env[:body] && env[:body][:client_secret]
          env[:body] = {} if env[:body].nil?
          env[:request_headers] = env[:request_headers].merge('Authorization' => "Bearer #{@access_token}")
        elsif @client_id && @client_secret
          # POST to oauth/token
          base64basic = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
          env[:request_headers] = env[:request_headers].merge('Authorization' => "Basic #{base64basic}")
          env[:body] = env[:body].merge(:client_id => @client_id)
        end
      end

      @app.call env
    end

    def initialize(app, client_id, client_secret, access_token=nil)
      @app = app
      @client_id = client_id
      @client_secret = client_secret
      @access_token = access_token
    end
  end
end
