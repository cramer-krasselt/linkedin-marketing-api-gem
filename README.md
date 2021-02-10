# Linkedin Marketing API - Unofficial gem
Quick hack on the Instagram Gem, adapted for the Linkedin Marketing API.

Not endpoint-complete by a far cry, not even tested at all.

This works for my purposes currently, but is obviously a use-at-own-risk piece of software.

## Usage

```ruby
require 'linkedin'

LinkedInAPI.configure do |config|
    # Required
    config.client_id		= ENV['TUBE_CLIENT_ID']
    config.client_secret	= ENV['TUBE_CLIENT_SECRET']
end

auth_result = LinkedInAPI.get_access_token
#<Hashie::Mash ... >

client = LinkedInAPI::Client.new(access_token: auth_result.token)
#<LinkedInAPI::Client ... >

client.campaigns
#<Hashie::Mash ... >
```
