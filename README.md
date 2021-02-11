# Linkedin Marketing API - Unofficial gem
Quick hack on the Instagram Gem, adapted for the Linkedin Marketing API.

Not endpoint-complete by a far cry, not even tested at all.

This works for my purposes currently, but is obviously a use-at-own-risk piece of software.

## Usage

```ruby
require 'linked_in'

LinkedInAPI.configure do |config|
    # Required
    config.client_id		= ENV['LINKEDIN_CLIENT_ID']
    config.client_secret	= ENV['LINKEDIN_CLIENT_SECRET']
    config.access_token     = ENV['LINKEDIN_ACCESS_TOKEN']
end

client = LinkedInAPI::Client.new
#<LinkedInAPI::Client ... >

client.campaigns
#<Hashie::Mash ... >
```
