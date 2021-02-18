module LinkedInAPI
  class Client
    module AdAccounts
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-account-users#find-ad-accounts-by-authenticated-user
      # e.g. GET https://api.linkedin.com/v2/adAccountUsersV2?q=authenticatedUser
      
      # all accounts the token has access to
      def ad_accounts(start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        options = {
          q: "authenticatedUser"
        }

        options.merge!(paging_params(start_index, page_size))

        get(Configuration::API_PREFIX + "adAccountUsersV2", options)
      end
    end
  end
end
