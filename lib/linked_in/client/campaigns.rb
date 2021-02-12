module LinkedInAPI
  class Client
    module Campaigns
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-campaign-groups
      # e.g. GET https://api.linkedin.com/v2/adCampaignGroupsV2?q=search&search.{searchCriteria}.values[0]={searchValue}
      # The following example searches for all campaign groups in ACTIVE and DRAFT status. The results are ordered by id in descending order.
      # GET https://api.linkedin.com/v2/adCampaignGroupsV2?q=search&search.status.values[0]=ACTIVE&search.status.values[1]=DRAFT&sort.field=ID&sort.order=DESCENDING

      def all_campaigns(q = nil)
        options = {
          q: "search"
        }
        # Optionals
        options.merge!(q: q) if q

        get(Configuration::API_PREFIX + "adCampaignsV2", options)
      end

      def get_campaign(campaign_id)
        options = {}

        get(Configuration::API_PREFIX + "adCampaignsV2/#{campaign_id}", options)

      end

      def campaign_group_campaigns(campaign_group_ids = [])
        mapped_campaign_group_ids = campaign_group_ids.map do |campaign_group_id|
          campaign_group_id_to_urn(campaign_group_id)
        end

        campaign_group_id_query = generate_search_options("campaignGroup", mapped_campaign_group_ids)

        #puts campaign_group_id_query

        search_campaigns(campaign_group_id_query)
      end

      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-campaigns#search-for-campaigns
      # GET https://api.linkedin.com/v2/adCampaignsV2?q=search&search.{searchCriteria}.values[0]={searchValue}
      def search_campaigns(search_queries = nil)
        # Optionals
        options = {
          q: "search",
        }

        options.merge!(search_queries) if search_queries

        get(Configuration::API_PREFIX + "adCampaignsV2", options)
      end

      def campaign_group_id_to_urn(campaign_group_id)
        "urn:li:sponsoredCampaignGroup:#{campaign_group_id}"
      end
    end
  end
end
