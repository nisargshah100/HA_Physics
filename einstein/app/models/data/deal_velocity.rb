class DealVelocity
  def self.compute(deals)
    deals = deals.map do |deal|
      purchases = deal.purchases
      last_purchase = purchases.last

      velocity = last_purchase.quantity.to_f / 
                 (last_purchase.created_at.to_f - deal.date_added.to_f)
      
      [velocity * 3600, deal]
    end

    deals.sort_by { |deal| -deal[0] }
  end
end