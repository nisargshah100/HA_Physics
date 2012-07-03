require 'spec_helper'

describe 'Revenue Projection' do
  let!(:deal1) do
    d1 = Deal.create(:original_id => '1', :title => "Deal 1", :price_cents => 100, :date_added => DateTime.now - 1, :end_date => DateTime.now + 1)
    d1.purchases.create(:quantity => 20)
    d1
  end

  let!(:deal2) do
    d2 = Deal.create(:original_id => '2', :title => "Deal 2", :price_cents => 100, :date_added => DateTime.now - 1, :end_date => DateTime.now + 1)
    d2.purchases.create(:quantity => 20)
    d2
  end

  it 'has the correct revenue projection' do
    rev = DealAnalysis.revenue_for_deal(deal1).to_f / 100
    time_taken = DateTime.now.to_i - deal1.date_added.to_i
    time_left = deal1.end_date.to_i - DateTime.now.to_i

    RevenueProjection.compute_for_deal(deal1).first.should == ((rev / time_taken) * time_left) + rev
  end

  it 'computes the revenue for multiple deals' do
    Deal.count.times do |deal_index|
      RevenueProjection.compute(Deal.all)[deal_index][0].should == 40
      RevenueProjection.compute(Deal.all)[deal_index][0].should == 40
    end
  end
end