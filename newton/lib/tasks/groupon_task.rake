require 'faraday'
require 'json'

class Groupon
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
      entry = GrouponEntryParser.new(entry)
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
  end
end

class GrouponEntryParser
  def initialize(entry)
    @entry ||= entry
  end

  def id
    @entry['options'].first['id']
  end

  def title
    @entry['title']
  end

  def date_added
    DateTime.parse(@entry['startAt'])
  end

  def end_date
    DateTime.parse(@entry['endAt'])
  end

  def price
    @entry['options'].first['price']['amount']
  end

  def value
    @entry['options'].first['discount']['amount']
  end

  def subtitle
    @entry['announcementTitle']
  end

  def original_url
    @entry['dealUrl']
  end

  def affiliate_url
    original_url
  end

  def image_url
    @entry['largeImageUrl']
  end

  def source
    @entry['type']
  end

  def as_json(*params)
    {
      :title => title,
      :date_added => date_added,
      :end_date => end_date,
      :price_cents => price,
      :value_cents => value,
      :subtitle => subtitle,
      :original_url => original_url,
      :affiliate_url => affiliate_url,
      :image_url => image_url,
      :source => source
    }
  end
end


namespace :groupon do
  task :fetch => :environment do
    GROUPON_API_KEY = "8e88a66c6469ebf827c44e42b27d065d556fa1f7"
    DIVISION_IDS = ["boston", "chicago", "los-angeles", "new-york", "san-francisco", "washington-dc"]
    groupon_client = Groupon.new(GROUPON_API_KEY)
    DIVISION_IDS.each do |division_id|
      groupon_client.fetch(division_id)
    end
  end
end