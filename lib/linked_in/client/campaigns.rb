module LinkedInAPI
  class Client
    module Campaigns
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-campaign-groups
      # e.g. GET https://api.linkedin.com/v2/adCampaignGroupsV2?q=search&search.{searchCriteria}.values[0]={searchValue}
      # The following example searches for all campaign groups in ACTIVE and DRAFT status. The results are ordered by id in descending order.
      # GET https://api.linkedin.com/v2/adCampaignGroupsV2?q=search&search.status.values[0]=ACTIVE&search.status.values[1]=DRAFT&sort.field=ID&sort.order=DESCENDING

      # all campaigns across all accounts
      def all_campaigns(start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        options = {
          q: "search"
        }
        # Optionals
        options.merge!(paging_params(start_index, page_size))

        get(Configuration::API_PREFIX + "adCampaignsV2", options)
      end

      # one campaign
      def get_campaign(campaign_id)
        options = {}

        get(Configuration::API_PREFIX + "adCampaignsV2/#{campaign_id}", options)
      end

      # campaigns for one account
      def account_campaigns(account_id, start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        account_ids = [account_id]
        accounts_campaigns(account_ids, start_index, page_size)
      end

      # campaigns for an array of accounts
      def accounts_campaigns(account_ids = [], start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        mapped_account_ids = account_ids.map do |account_id|
          account_id_to_urn(account_id)
        end

        account_id_query = generate_search_options("account", mapped_account_ids)
        search_campaigns(account_id_query, start_index, page_size)
      end

      # campaigns for one campaign group
      def campaign_group_campaigns(campaign_group_id, start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        campaign_group_ids = [campaign_group_id]
        campaigns_group_campaigns(campaign_group_ids, start_index, page_size)
      end

      # campaigns for an array of campaign groups
      def campaign_groups_campaigns(campaign_group_ids = [], start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        mapped_campaign_group_ids = campaign_group_ids.map do |campaign_group_id|
          campaign_group_id_to_urn(campaign_group_id)
        end

        campaign_group_id_query = generate_search_options("campaignGroup", mapped_campaign_group_ids)
        search_campaigns(campaign_group_id_query, start_index, page_size)
      end

      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-campaigns#search-for-campaigns
      # GET https://api.linkedin.com/v2/adCampaignsV2?q=search&search.{searchCriteria}.values[0]={searchValue}
      def search_campaigns(search_queries = nil, start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        # Optionals
        options = {
          q: "search",
        }

        options.merge!(paging_params(start_index, page_size))
        options.merge!(search_queries) if search_queries

        get(Configuration::API_PREFIX + "adCampaignsV2", options)
      end

    end
  end
end
