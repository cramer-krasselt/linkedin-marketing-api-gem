module LinkedInAPI
  class Client
    module Conversions
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads-reporting/conversion-tracking#conversions
      # e.g. GET https://api.linkedin.com/v2/conversions?q=account&account=urn:li:sponsoredAccount:{account_id}
      
      # all conversions for the account
      def account_conversions(account_id, start_index = 0, page_size = Configuration::DEFAULT_PAGE_SIZE)
        full_account_id = account_id_to_urn(account_id)

        options = {}
        options.merge!(q: "account")
        options.merge!(account: full_account_id)
        options.merge!(paging_params(start_index, page_size))

        get(Configuration::API_PREFIX + "conversions", options)
      end
    end
  end
end
