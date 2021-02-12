module LinkedInAPI
  class Client
    module CampaignGroups
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-campaign-groups
      # e.g. GET https://api.linkedin.com/v2/adCampaignGroupsV2?q=search&search.{searchCriteria}.values[0]={searchValue}
      # The following example searches for all campaign groups in ACTIVE and DRAFT status. The results are ordered by id in descending order.
      # GET https://api.linkedin.com/v2/adCampaignGroupsV2?q=search&search.status.values[0]=ACTIVE&search.status.values[1]=DRAFT&sort.field=ID&sort.order=DESCENDING

      def campaign_groups(q = nil)
        options = {
          q: "search"
        }
        # Optionals
        options.merge!(q: q) if q

        get(Configuration::API_PREFIX + "adCampaignGroupsV2", options)
      end

      def account_campaign_groups(account_ids = [])
        mapped_account_ids = account_ids.map do |account_id|
          account_id_to_urn(account_id)
        end

        account_id_query = generate_search_options("account", mapped_account_ids)

        #puts account_id_query
        
        search_campaign_groups(account_id_query)
      end

      def search_campaign_groups(search_queries = nil)
        # Optionals
        options = {
          q: "search",
        }

        options.merge!(search_queries) if search_queries

        get(Configuration::API_PREFIX + "adCampaignGroupsV2", options)
      end
      
      def account_id_to_urn(account_id)
        "urn:li:sponsoredAccount:#{account_id}"
      end
    end
  end
end
