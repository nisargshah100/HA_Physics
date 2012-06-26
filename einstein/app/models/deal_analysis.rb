class DealAnalysis
  include Mongoid::Document
  include Mongoid::Timestamps

  field :groupon_deal_velocity
  field :livingsocial_deal_velocity

  def self.compute
    analysis = DealAnalysis.new
    analysis.compute_groupon_deal_velocity_by_hour
    analysis.compute_livingsocial_deal_velocity_by_hour

    analysis.save()
  end

  def compute_groupon_deal_velocity_by_hour
    DealAnalysis.compute_deal_velocity_by_hour('groupon') do |velocity|  
      self.groupon_deal_velocity = velocity.to_json
    end
  end

  def compute_livingsocial_deal_velocity_by_hour
    DealAnalysis.compute_deal_velocity_by_hour('LivingSocial') do |velocity|
      self.livingsocial_deal_velocity = velocity.to_json
    end
  end

  private

  # Deal (quantity / time)
  def self.compute_deal_velocity_by_hour(source, limit=10)
    deals = self.find_unique_deals(source)

    # return deals
    deals = deals.map do |deal|
      purchases = deal.purchases
      last_purchase = purchases.last

      velocity = last_purchase.quantity.to_f / 
                 (last_purchase.created_at.to_f - deal.date_added.to_f)
      
      [velocity * 3600, deal]
    end

    yield deals.sort_by { |deal| -deal[0] }[0...limit]
  end

  def self.find_unique_deals(source)
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