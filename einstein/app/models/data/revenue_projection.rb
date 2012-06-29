class RevenueProjection
  def self.compute(deals)
    revenues = deals.map { |deal| RevenueProjection.compute_for_deal(deal) }
  end

  # Compute:
  # Revenue for the particular deal
  # Divide it by the seconds taken. (velocity = revenue / seconds taken)
  # Multiply by the seconds left for the deal
  def self.compute_for_deal(deal)
    revenue = DealAnalysis.revenue_for_deal(deal)
    velocity = revenue.to_f / deal.end_date.to_i - DateTime.now.to_i

    if deal.end_date and deal.end_date > DateTime.now and not deal.sold_out
      seconds_left = deal.end_date.to_i - DateTime.now.to_i
    else
      seconds_left = 0
    end

    [velocity * seconds_left, deal]
  end
end