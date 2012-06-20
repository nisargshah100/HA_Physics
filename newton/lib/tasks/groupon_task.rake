require 'faraday'
require 'json'

class Groupon
  API_BASE_URL = "http://api.groupon.com/v2/"

  def initialize(api_key)
    @api_key = api_key
  end

  def fetch(division_id)
    conn = Faraday.new(:url => API_BASE_URL)
    @division_id = division_id
    response = conn.get do |req|
      req.url 'deals'
      req.params['client_id'] = @api_key
      req.params['division_id'] = @division_id
    end
  end
end

namespace :groupon do
  task :fetch => :environment do
    GROUPON_API_KEY = "8e88a66c6469ebf827c44e42b27d065d556fa1f7"
    Groupon.new(GROUPON_API_KEY).fetch("washington-dc")
  end
end