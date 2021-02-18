module LinkedInAPI
  class Client
    module CampaignGroups
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-campaign-groups
      # e.g. GET https://api.linkedin.com/v2/adCampaignGroupsV2?q=search&search.{searchCriteria}.values[0]={searchValue}
      # The following example searches for all campaign groups in ACTIVE and DRAFT status. The results are ordered by id in descending order.
      # GET https://api.linkedin.com/v2/adCampaignGroupsV2?q=search&search.status.values[0]=ACTIVE&search.status.values[1]=DRAFT&sort.field=ID&sort.order=DESCENDING

      # all campaign groups across all accounts
      def campaign_groups(start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        options = {
          q: "search"
        }

        options.merge!(paging_params(start_index, page_size))

        get(Configuration::API_PREFIX + "adCampaignGroupsV2", options)
      end

      def account_campaign_groups(account_id, start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        account_ids = [account_id]
        accounts_campaign_groups(account_ids, start_index, page_size)
      end

      def accounts_campaign_groups(account_ids = [], start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        mapped_account_ids = account_ids.map do |account_id|
          account_id_to_urn(account_id)
        end

        account_id_query = generate_search_options("account", mapped_account_ids)

        search_campaign_groups(account_id_query, start_index, page_size)
      end

      def search_campaign_groups(search_queries = nil, start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        # Optionals
        options = {
          q: "search",
        }
        
        options.merge!(paging_params(start_index, page_size))
        options.merge!(search_queries) if search_queries

        get(Configuration::API_PREFIX + "adCampaignGroupsV2", options)
      end
      
    end
  end
end
