require 'instagram'
require 'faraday'

INSTAGRAM_CLIENT_ID = "20298a13d8404b5da50887561cd0f228"
INSTAGRAM_SECRET = "2372a50989304d4a9375ba5a1e0536d3"

Instagram.configure do |config|
  config.client_id     = INSTAGRAM_CLIENT_ID
  config.client_secret = INSTAGRAM_SECRET
end

# result = Instagram.media_search("40.7143528", "-74.00597309999999")
# puts result.data.map { |response| response.images.standard_resolution.url }
###This will return an array of img urls
