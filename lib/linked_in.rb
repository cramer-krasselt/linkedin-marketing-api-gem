require File.expand_path('../linked_in/error', __FILE__)
require File.expand_path('../linked_in/configuration', __FILE__)
require File.expand_path('../linked_in/api', __FILE__)
require File.expand_path('../linked_in/client', __FILE__)
require File.expand_path('../linked_in/response', __FILE__)

module LinkedInAPI
  extend Configuration

  # Alias for LinkedInAPI::Client.new
  #
  # @return [LinkedInAPI::Client]
  def self.client(options={})
    LinkedInAPI::Client.new(options)
  end

  # Delegate to LinkedInAPI::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to LinkedInAPI::Client
  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method, include_all) || super
  end
end
