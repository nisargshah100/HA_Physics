require 'faraday'
require 'json'

class GrouponDeal
  API_BASE_URL = "http://api.groupon.com/v2/"

  def initialize(api_key)
    @api_key = api_key
  end

  def fetch(division_id)
    @division_id = division_id
    data = Faraday.new(:url => API_BASE_URL).get do |req|
      req.url 'deals'
      req.params['client_id'] = @api_key
      req.params['division_id'] = @division_id
    end

    get_entries(data).each do |entry|
      entry = GrouponDealParser.new(entry)
      save_entry(entry)
    end
  end

  def get_entries(data)
    JSON.parse(data.body)["deals"]
  end

  def save_entry(entry)
    deal = Deal.where(:original_id => entry.id).first
    if not deal
      deal = Deal.new(:original_id => entry.id)
      deal.attributes = entry.as_json
      deal.save()
      puts "Deal saved! #{deal.title}"
    end

    if deal
      deal.purchases.create(:quantity => entry.quantity)
      deal.original_category = entry.category
      deal.original_subcategory = entry.subcategory
      deal.save()
    end
  end
end