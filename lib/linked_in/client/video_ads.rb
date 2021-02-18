module LinkedInAPI
  class Client
    module VideoAds
      # https://docs.microsoft.com/en-us/linkedin/marketing/integrations/ads/advertising-targeting/create-and-manage-video#fetch-a-video-ad
      # e.g. GET https://api.linkedin.com/v2/adDirectSponsoredContents/urn:li:ugcPost:{video_post_id}
      
      # get one video ad
      def get_video_ad(video_ad_id)
        full_video_ad_id = video_id_to_urn(video_ad_id)

        # Optionals
        options = {}

        get(Configuration::API_PREFIX + "adDirectSponsoredContents/#{full_video_ad_id}", options)
      end
    end
  end
end
