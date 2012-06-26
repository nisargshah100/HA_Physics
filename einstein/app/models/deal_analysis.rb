class DealAnalysis
  include Mongoid::Document
  include Mongoid::Timestamps

  field :groupon_deal_velocity
  field :livingsocial_deal_velocity

  field :livingsocial_top_districts
  field :groupon_top_districts

  def self.compute
    analysis = DealAnalysis.new
    analysis.compute_groupon_deal_velocity_by_hour
    analysis.compute_livingsocial_deal_velocity_by_hour

    analysis.compute_livingsocial_top_districts
    analysis.compute_groupon_top_districts

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

  def compute_livingsocial_top_districts
    DealAnalysis.compute_top_districts('LivingSocial') do |districts|
      self.livingsocial_top_districts = districts.to_json
    end
  end

  def compute_groupon_top_districts
    DealAnalysis.compute_top_districts('groupon') do |districts|
      self.groupon_top_districts = districts.to_json
    end
  end

  private

  def self.compute_top_districts(source, limit=10)
    deals = Deal.all.group_by { |deal| deal.division_name }
    deal_values = {}

    deals.each do |k,v|
      revenue = compute_revenue_for_deals(v)
      deal_values[k] = revenue
    end

    yield Hash[deal_values.sort_by { |k,v| -v}]
  end

  def self.compute_revenue_for_deals(deals)
    deals.map { |deal| deal.value_cents * deal.purchases.last.quantity.to_i }.sum
  end

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