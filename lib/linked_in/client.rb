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
    include LinkedInAPI::Client::Campaigns
    include LinkedInAPI::Client::Creatives

    def generate_search_options(criteria = "", values = [])
      values.map.with_index(0) do |value, index|
        { "search.#{criteria}.values[#{index}]" => value }
      end.reduce(options={}) do |options, query|
        options.merge(query)
      end
    end
  end
end
