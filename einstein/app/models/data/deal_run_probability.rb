class DealRunProbability
  def self.compute(deals, date)
    # c = Classifier::Bayes.new 'Run', 'Not Run'
    # deals = deals.all.to_a
    
    # (1..54).each do |i|
    #   weekly_deals = deals.select { |deal| deal.date_added.cweek == i || deal.end_date.cweek == i }

    #   if weekly_deals.count > 0
    #     c.train 'Run', "week#{i}"
    #   end
    # end

    # raise c.inspect
    # puts c.classify "week26"
    # puts c.classify "week3"

    slope = compute_slope(deals)
    puts will_run_based_on_slope(slope, deals, date)
  end

  # Checks the possibility of deal occuring based on the previous weeks
  # the deal has run. (for ex/ if the deal ran in 2010 on week 10 for spa), 
  # there is a higher probability of the deal running in week 10.

  def self.naiive_bayes(deals)

  end

  # Checks how often the deal is run and based on the the possiblity of 
  # running it again.

  def self.compute_slope(deals)
    avg = 0
    diffs = []
    deals = deals.select { |d| d.date_added != nil }.sort_by { |d| d.date_added }

    i = 0
    while(i < deals.count - 1)
      deal = deals[i]
      next_deal = deals[i+1]

      if deal and next_deal
        diffs << next_deal.date_added.to_date - deal.date_added.to_date
      end

      i += 1
    end
    avg = diffs.sum.to_f / diffs.count.to_f
    avg
  end

  def self.will_run_based_on_slope(slope, deals, date)
    deal = deals.sort_by { |d| d.date_added }.last
    if deal 
      diff = (date.to_date - deal.date_added.to_date)
      [diff >= slope, diff]
    else
      [false, -1]
    end
  end
end