require 'faraday'
require 'json'

class GrouponDivisionHandler
  API_BASE_URL = "http://api.groupon.com/v2/"

  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_all
    data = Faraday.new(:url => API_BASE_URL).get do |req|
      req.url 'divisions'
      req.params['client_id'] = @api_key
    end

    get_entries(data).each do |entry|
      entry = GrouponDivisionParser.new(entry)
      save_entry(entry)
    end
  end

  def get_entries(data)
    JSON.parse(data.body)["divisions"]
  end

  def save_entry(entry)
    division = GrouponDivision.where(:division_id => entry.division_id).first
    if not division
      division = GrouponDivision.new(:division_id => entry.division_id)
      division.attributes = entry.as_json
      division.save()
      puts "Division saved! #{division.name}"
    end
  end
end