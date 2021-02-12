require 'openssl'
require 'base64'
require 'pry'

module LinkedInAPI
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options = {}, signature = false, raw = false, no_response_wrapper = no_response_wrapper(), signed = sign_requests, request_connection_options = {})
      request(:get, path, options, signature, raw, no_response_wrapper, signed)
    end

    # Perform an HTTP POST request
    def post(path, options = {}, signature = false, raw = false, no_response_wrapper = no_response_wrapper(), signed = sign_requests, request_connection_options = {})
      request(:post, path, options, signature, raw, no_response_wrapper, signed)
    end

    # Perform an HTTP PUT request
    def put(path, options = {}, signature = false, raw = false, no_response_wrapper = no_response_wrapper(), signed = sign_requests, request_connection_options = {})
      request(:put, path, options, signature, raw, no_response_wrapper, signed)
    end

    # Perform an HTTP DELETE request
    def delete(path, options = {}, signature = false, raw = false, no_response_wrapper = no_response_wrapper(), signed = sign_requests, request_connection_options = {})
      request(:delete, path, options, signature, raw, no_response_wrapper, signed)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, signature = false, raw = false, no_response_wrapper = false, signed = sign_requests, request_connection_options = {})
      response = connection(raw).send(method) do |request|
        case method
        when :get, :delete
          request.url(URI.encode(path), options)
        when :post, :put
          request.path = URI.encode(path)
          request.body = options unless options.empty?
        end
      end

      return response if raw
      return response.body if no_response_wrapper

      ratelimit_hash = {}

      ratelimit_hash.merge!(limit: response.headers['x-ratelimit-limit'].to_i) if response.headers['x-ratelimit-limit']
      ratelimit_hash.merge!(remaining: response.headers['x-ratelimit-remaining'].to_i) if response.headers['x-ratelimit-remaining']

      return Response.create(response.body, ratelimit_hash)
    end
  end
end
