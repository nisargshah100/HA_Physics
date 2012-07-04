Geocoder.configure do |config|

  # geocoding service (see below for supported options):
  config.lookup = :google

  # to use an API key:
  # config.api_key = "AIzaSyBuOoNZkXabgWJpnxCFtzx0ZHzYK08DR-w"

  # geocoding service request timeout, in seconds (default 3):
  config.timeout = 5

  # set default units to kilometers:
  config.units = :mi

  # caching (see below for details):
  # config.cache = Redis.new()
  # config.cache_prefix = "geocoder:"
end