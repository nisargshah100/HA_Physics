require 'faraday'
require 'json'
require 'groupon_deal.rb'
require 'groupon_deal_parser.rb'
require 'groupon_division_handler.rb'
require 'groupon_division_parser.rb'
require 'date'

namespace :groupon do
  task :fetch_deals => :environment do
    puts "GROUPON FETCH DEALS - #{DateTime.now}"
    GROUPON_API_KEY = "8e88a66c6469ebf827c44e42b27d065d556fa1f7"
    # DIVISION_IDS = ["boston", "chicago", "los-angeles", "new-york", "san-francisco", "washington-dc"]
    # DIVISION_IDS = ["boston"]
    DIVISION_IDS = GrouponDivision.all.map { |gd| gd.division_id }

    groupon_client = GrouponDeal.new(GROUPON_API_KEY)
    # DIVISION_IDS = GrouponDivision.pluck("division_id")
    # DIVISION_IDS = GrouponDivision.all.map(&:"division_id")
    DIVISION_IDS.each do |division_id|
      groupon_client.fetch(division_id)
    end
  end

  task :fetch_divisions => :environment do
    puts "GROUPON FETCH DIVISIONS - #{DateTime.now}"
    GROUPON_API_KEY = "8e88a66c6469ebf827c44e42b27d065d556fa1f7"
    groupon_client = GrouponDivisionHandler.new(GROUPON_API_KEY)
    groupon_client.fetch_all
  end
end