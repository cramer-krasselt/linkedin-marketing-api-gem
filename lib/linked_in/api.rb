require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)
require File.expand_path('../oauth', __FILE__)

module LinkedInAPI
  # @private
  class API
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      options = LinkedInAPI.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end

    include Connection
    include Request
    include OAuth

    def refresh_access_token!
      res = refresh_access_token
      self.access_token = res["access_token"]
      self.access_expiry = Time.now + res["expires_in"]

      self.refresh_token = res["refresh_token"]
      self.refresh_token_expiry = res["refresh_token_expires_in"]
      nil
    end
  end
end
