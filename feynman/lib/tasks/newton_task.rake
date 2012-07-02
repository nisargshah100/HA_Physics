require 'faraday'
require 'json'
require 'date'

class Newton
  NEWTON_BASE_URL = "http://50.116.44.82:3000/api/v1/"

  def self.get_data
    puts 'Downloading deals from Newton...'

    data = Faraday.new(:url => NEWTON_BASE_URL).get do |req|
      req.url 'events'
    end
  end

  def self.fetch(&block)
    data = JSON.parse(get_data.body)
    puts 'Parsing...'

    data.each do |entry|
      save_entry(NewtonParser.parse(entry))
    end
  end

  def self.save_entry(deal_params)
    deal = Deal.find_by_id(deal_params["original_id"])
    if not deal
      deal = Deal.create!(deal_params)
      puts "Deal saved! #{deal.title}"
    else
      puts "HERE"
      deal.last_purchase_count = deal_params["last_purchase_count"]
      deal.sold_out = deal_params["sold_out"]
      deal.save()
    end
  end
end

class NewtonParser
  def self.parse(entry)
    entry.delete("_id")
    entry.delete("created_at")
    entry.delete("updated_at")
    purchases = entry.delete("purchases")
    division_latlon = entry.delete("division_latlon")

    entry.merge!({ "id" => entry["original_id"],
                   "latitude" => division_latlon[0], 
                   "longitude" => division_latlon[1],
                   "last_purchase_count" => purchases.last["quantity"]})
  end
end

namespace :newton do
  task :fetch_deals => :environment do
    puts "NEWTON - #{DateTime.now}"
    Newton.fetch do |entry|
      Newton.save_entry(entry)
    end
  end
end