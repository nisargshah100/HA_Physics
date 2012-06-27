class TopDistricts
  def self.compute(deals)
    deals = deals.group_by { |deal| deal.division_name }
    deal_values = {}

    deals.each do |k,v|
      revenue = DealAnalysis.revenue(v)
      deal_values[k] = revenue
    end

    Hash[deal_values.sort_by { |k,v| -v}]
  end
end