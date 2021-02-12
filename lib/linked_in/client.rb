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

    private

      def generate_search_options(criteria = "", values = [])
        values.map.with_index(0) do |value, index|
          { "search.#{criteria}.values[#{index}]" => value }
        end.reduce(options = {}) do |options, query|
          options.merge(query)
        end
      end

      class DoNotEncoder
        def self.encode(params)
          buffer = ''
          params.each do |key, value|
            buffer << "#{key}=#{value}&"
          end
          return buffer.chop
        end
      end

      def account_id_to_urn(account_id)
        "urn:li:sponsoredAccount:#{account_id}"
      end
  
      def campaign_group_id_to_urn(campaign_group_id)
        "urn:li:sponsoredCampaignGroup:#{campaign_group_id}"
      end  
    end
  end
end
