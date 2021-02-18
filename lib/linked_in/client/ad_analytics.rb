require 'date'

module LinkedInAPI
  class Client
    module AdAnalytics
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads-reporting/ads-reporting#statistics-finder
      # e.g. GET https://api.linkedin.com/v2/adAnalyticsV2?q=statistics&pivots[0]=CAMPAIGN&dateRange.start.day=1&dateRange.start.month=1&dateRange.start.year=2017&timeGranularity=DAILY&campaigns[0]=urn:li:sponsoredCampaign:1234567
      
      # while this accepts the paging parameters, it doesn't actually work
      def campaign_ad_analytics(campaign_id, start_date, end_date, time_granularity, pivots = [], fields = [])
        options = {}

        #campaign_id
        options.merge!("campaigns" => campaign_id_to_urn(campaign_id))
        # uncomment next three if using an array of campaign ids, but we aren't supporting this for now
        #campaign_ids.map do |campaign_id|
        #  options.merge!("campaigns" => campaign_id_to_urn(campaign_id)
        #end

        #pivots
        pivots.map.with_index(0) do |pivot, index|
          { "pivots[#{index}]" => pivot }
        end.reduce(pivot_options = {}) do |pivot_options, query|
          options.merge!(query)
        end

        #fields
        field_list = fields.join(",")
        options.merge!(fields: field_list)

        # Time Granularity
        options.merge!(timeGranularity: time_granularity)

        # Requirements
        start_date = Date.parse(start_date)
        end_date = Date.parse(end_date)

        options.merge!("dateRange.start.day" => start_date.day )
        options.merge!("dateRange.start.month" => start_date.month )
        options.merge!("dateRange.start.year" => start_date.year )

        options.merge!("dateRange.end.day" => end_date.day )
        options.merge!("dateRange.end.month" => start_date.month )
        options.merge!("dateRange.end.year" => start_date.year )

        search_ad_analytics(options)
      end

      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads-reporting/ads-reporting#statistics-finder
      # e.g. GET https://api.linkedin.com/v2/adAnalyticsV2?q=statistics&pivots[0]=CAMPAIGN&dateRange.start.day=1&dateRange.start.month=1&dateRange.start.year=2017&timeGranularity=DAILY&campaigns[0]=urn:li:sponsoredCampaign:1234567
      def search_ad_analytics(search_queries = nil)
        # Optionals
        options = {
          q: "statistics",
        }

        options.merge!(search_queries) if search_queries

        get(Configuration::API_PREFIX + "adAnalyticsV2", options)
      end
    end
  end
end
