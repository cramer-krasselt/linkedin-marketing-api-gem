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
end

auth_result = LinkedInAPI.get_access_token
#<Hashie::Mash ... >

#client = LinkedInAPI::Client.new(access_token: auth_result.token)
client = LinkedInAPI::Client.new(access_token: auth_result.access_token)
#<LinkedInAPI::Client ... >

client.campaigns
#<Hashie::Mash ... >
```
