module LinkedInAPI
  # Wrapper for the LinkedInAPI REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in http://instagram.com/developer/
  # @see http://instagram.com/developer/
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include LinkedInAPI::Client::Profiles
    include LinkedInAPI::Client::AdAccounts
    include LinkedInAPI::Client::CampaignGroups
  end
end
