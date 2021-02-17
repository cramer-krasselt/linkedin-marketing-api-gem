module LinkedInAPI
  class Client
    module Creatives
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-creatives#get-a-creative
      # e.g. GET https://api.linkedin.com/v2/adCreativesV2/{CREATIVE_ID}
      def get_creative(creative_id, projection = nil)
        # Optionals
        options = {}
        options.merge!(projection: projection) if projection

        get(Configuration::API_PREFIX + "adCreativesV2/#{creative_id}", options)
      end

      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-creatives#get-a-creative-name
      # e.g. GET https://api.linkedin.com/v2/adCreativesV2/{creativeId}?projection=
      # (variables(data(*,com.linkedin.ads.SponsoredUpdateCreativeVariables(*,share~(subject,text(text),content(contentEntities(*(description,entityLocation,title))))))))
      def get_creative_name(creative_id)
        # Optionals
        options = {
          projection: "(variables(data(*,com.linkedin.ads.SponsoredUpdateCreativeVariables(*,share~(subject,text(text),content(contentEntities(*(description,entityLocation,title))))))))"
        }

        get(Configuration::API_PREFIX + "adCreativesV2/#{creative_id}", options)
      end

      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-creatives#text-ads-created-with-campaign-manager
      # e.g. GET https://api.linkedin.com/v2/adCreativesV2/52968586?projection=(variables(data(com.linkedin.ads.TextAdCreativeVariables(vectorImage~:playableStreams))))
      def get_text_ads(creative_id)
        # Optionals
        options = {
          projection: "(variables(data(com.linkedin.ads.TextAdCreativeVariables(vectorImage~:playableStreams))))"
        }

        get(Configuration::API_PREFIX + "adCreativesV2/#{creative_id}", options, signature = false, raw = true)
      end

      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-creatives#search-for-creatives
      # GET https://api.linkedin.com/v2/adCreativesV2?q=search&search.{searchCriteria}.values[0]={searchValue}
      def search_creatives(search_queries = nil)
        # Optionals
        options = {
          q: "search",
        }

        options.merge!(search_queries) if search_queries

        get(Configuration::API_PREFIX + "adCreativesV2", options)
      end

      def campaign_creatives(campaign_ids = [])
        mapped_campaign_ids = campaign_ids.map do |campaign_id|
          campaign_id_to_urn(campaign_id)
        end

        campaign_id_query = generate_search_options("campaign", mapped_campaign_ids)

        search_creatives(campaign_id_query)
      end

      def all_creatives
        search_creatives
      end

      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/account-structure/create-and-manage-creatives#batch-get-ad-creatives
      # e.g. GET https://api.linkedin.com/v2/adCreativesV2?ids=List(47771456,47771492)
      # must include this header: X-Restli-Protocol-Version: 2.0.0
      #
      # ad_ids are creative_ids
      def ad_creatives(creative_ids)
        # Optionals
        options = {
          ids: "List(#{creative_ids.join(',')})",
        }

        get(Configuration::API_PREFIX + "adCreativesV2", options, false, false,
            no_response_wrapper(), sign_requests,
            headers: { "X-Restli-Protocol-Version" => "2.0.0" },
            request: { params_encoder: DoNotEncoder } )
      end
    end
  end
end
