require 'faraday'
require 'thread'
require File.expand_path('../version', __FILE__)

module LinkedInAPI
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {LinkedInAPI::API}
    VALID_OPTIONS_KEYS = [
      :access_expiry,
      :access_expiry_ahead,
      :access_mutex,
      :access_token,
      :adapter,
      :client_id,
      :client_ips,
      :client_secret,
      :connection_options,
      :endpoint,
      :format,
      :loud_logger,
      :no_response_wrapper,
      :proxy,
      :redirect_uri,
      :refresh_token,
      :scope,
      :sign_requests,
      :user_agent,
    ].freeze

    # By default, don't set a user access token
    DEFAULT_ACCESS_TOKEN = nil

    DEFAULT_ACCESS_EXPIRY = Time.now

    # Mark token as expired N seconds before #access_expiry
    DEFAULT_ACCESS_EXPIRY_AHEAD = 30

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set an application ID
    DEFAULT_CLIENT_ID = nil

    # By default, don't set an application secret
    DEFAULT_CLIENT_SECRET = nil

    # By default, don't set application IPs
    DEFAULT_CLIENT_IPS = nil

    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    # https://www.linkedin.com/oauth/v2/accessToken
    DEFAULT_ENDPOINT = 'https://api.linkedin.com/'.freeze

    API_PREFIX = "v2/"

    DEFAULT_TIMEZONE = 'America/Chicago'

    DEFAULT_PAGINATION_LIMIT = 50

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is the only available format at this time
    DEFAULT_FORMAT = :json

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # By default, don't set an application redirect uri
    DEFAULT_REDIRECT_URI = nil

    # By default, don't set a user scope
    DEFAULT_SCOPE = nil

    # By default, don't wrap responses with meta data (i.e. pagination)
    DEFAULT_NO_RESPONSE_WRAPPER = false

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "LinkedInAPI Ruby Gem #{LinkedInAPI::VERSION}".freeze

    # An array of valid request/response formats
    #
    # @note Not all methods support the XML format.
    VALID_FORMATS = [
      :json].freeze

    # By default, don't turn on loud logging
    DEFAULT_LOUD_LOGGER = nil

    # By default, requests are not signed
    DEFAULT_SIGN_REQUESTS = false

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Note: relies on server time
    def token_expired?
      (self.access_expiry - self.access_expiry_ahead) < Time.now
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.access_token         = DEFAULT_ACCESS_TOKEN
      self.access_expiry        = DEFAULT_ACCESS_EXPIRY
      self.access_expiry_ahead  = DEFAULT_ACCESS_EXPIRY_AHEAD
      self.adapter              = DEFAULT_ADAPTER
      self.client_id            = DEFAULT_CLIENT_ID
      self.client_secret        = DEFAULT_CLIENT_SECRET
      self.client_ips           = DEFAULT_CLIENT_IPS
      self.connection_options   = DEFAULT_CONNECTION_OPTIONS
      self.scope                = DEFAULT_SCOPE
      self.redirect_uri         = DEFAULT_REDIRECT_URI
      self.endpoint             = DEFAULT_ENDPOINT
      self.format               = DEFAULT_FORMAT
      self.proxy                = DEFAULT_PROXY
      self.user_agent           = DEFAULT_USER_AGENT
      self.no_response_wrapper  = DEFAULT_NO_RESPONSE_WRAPPER
      self.loud_logger          = DEFAULT_LOUD_LOGGER
      self.sign_requests        = DEFAULT_SIGN_REQUESTS
    end
  end
end
