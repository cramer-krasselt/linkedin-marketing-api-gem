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
    end
  end
end
