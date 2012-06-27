require 'data/deal_velocity'
require 'data/top_districts'

GROUPON = 'groupon'
LS = 'LivingSocial'

class DealAnalysis
  include Mongoid::Document
  include Mongoid::Timestamps

  field :groupon_deal_velocity
  field :livingsocial_deal_velocity

  field :livingsocial_top_districts
  field :groupon_top_districts

  def self.compute
    analysis = DealAnalysis.new
    analysis.compute_deal_velocity
    analysis.compute_top_districts
    analysis.save()
  end

  def compute_deal_velocity(limit=10)
    vel_g  = DealVelocity.compute(DealAnalysis.unique_deals(source=GROUPON))
    vel_ls = DealVelocity.compute(DealAnalysis.unique_deals(source=LS))

    self.groupon_deal_velocity = vel_g[0...limit].to_json
    self.livingsocial_deal_velocity = vel_ls[0...limit].to_json
  end

  def compute_top_districts
    dis_g  = TopDistricts.compute(Deal.groupon_deals)
    dis_ls = TopDistricts.compute(Deal.livingsocial_deals)

    self.groupon_top_districts = dis_g.to_json
    self.livingsocial_top_districts = dis_ls.to_json
  end

  # Helper functions

  def self.revenue(deals)
    deals.map { |deal| deal.price_cents * deal.purchases.last.quantity.to_i }.sum
  end

  def self.unique_deals(source)
    titles = Deal.all.distinct(:title)
    all_deals = Deal.where(:source => source)
    uniq_deals = []

    all_deals.each do |d| 
      if titles.include?(d.title)
        uniq_deals << d
        titles.delete(d.title)
      end
    end

    uniq_deals
  end

end