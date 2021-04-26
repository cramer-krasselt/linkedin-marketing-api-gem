# Linkedin Marketing API - Unofficial gem

Quick hack on the Instagram Gem, adapted for the Linkedin Marketing API.

Not endpoint-complete by a far cry, not even tested at all.

This works for my purposes currently, but is obviously a use-at-own-risk piece of software.

## Usage

```ruby
require 'linked_in'

LinkedInAPI.configure do |config|
  # Required
  config.client_id     = ENV['LINKEDIN_CLIENT_ID']
  config.client_secret = ENV['LINKEDIN_CLIENT_SECRET']
  config.access_token  = ENV['LINKEDIN_ACCESS_TOKEN']
  config.refresh_token = ENV['LINKEDIN_REFRESH_TOKEN']
end

client = LinkedInAPI::Client.new
=> #<LinkedInAPI::Client ... >
  
client.LinkedInAPI.refresh_access_token!
=> nil

client.ad_accounts()
=> #<Hashie::Mash ... >

client.account_campaign_groups({ACCOUNT_ID})
=> #<Hashie::Mash ... >

client.account_campaigns({ACCOUNT_ID})
=> #<Hashie::Mash ... >

client.campaign_creatives({CAMPAIGN_ID})
=> #<Hashie::Mash ... >

client.get_video_ad({SPONSORED_VIDEO_POST_ID})
=> #<Hashie::Mash ... >

client.get_share({SPONSORED_SHARE_ID})
=> #<Hashie::Mash ... >

client.get_adinmail({SPONSORED_INMAIL_ID})
=> #<Hashie::Mash ... >

client.account_conversions({ACCOUNT_ID})
=> #<Hashie::Mash ... >

client.campaign_ad_analytics({CAMPAIGN_ID},{START_DATE},{END_DATE},{GRANULARITY},[{PIVOT_ARRAY}],[{FIELD_ARRAY}])

Supports paging with optional parameters (start_index, page_size) on list endpoints other than campaign_ad_analytics because LinkedIn does not support it on that endpoint.
```
