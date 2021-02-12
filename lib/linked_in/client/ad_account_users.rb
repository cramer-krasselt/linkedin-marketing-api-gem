module LinkedInAPI
  class Client
    module AdAccounts
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-account-users#find-ad-accounts-by-authenticated-user
      # e.g. GET https://api.linkedin.com/v2/adAccountUsersV2?q=authenticatedUser
      def ad_accounts(q = nil)
        options = {
          q: "authenticatedUser"
        }
        # Optionals
        options.merge!(q: q) if q

        get(Configuration::API_PREFIX + "adAccountUsersV2", options)
      end
    end
  end
end
