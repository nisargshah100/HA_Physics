class DealRunProbability
  def self.compute(deals, date)
    slope = compute_slope(deals)
    will_run_based_on_slope(slope, deals, date)
  end

  # Checks how often the deal is run and based on the the possiblity of 
  # running it again.

  def self.compute_slope(deals)
    avg = 0
    diffs = []
    deals = deals.select { |d| d.date_added != nil }.sort_by { |d| d.date_added }

    i = 0
    while(i < deals.count)
      deal = deals[i]
      next_deal = deals[i+1]

      if deal and next_deal
        diffs << next_deal.date_added.to_date - deal.date_added.to_date
      end

      i += 1
    end

    if diffs.count > 0
      avg = diffs.sum.to_f / diffs.count.to_f
    end
    
    avg
  end

  def self.will_run_based_on_slope(slope, deals, date)
    deal = deals.select { |d| d.date_added != nil }.sort_by { |d| d.date_added }.last
    if deal 
      diff = (date.to_date - deal.date_added.to_date)
      [diff >= slope, diff, slope]
    else
      [false, -1, 0]
    end
  end
end