require 'spec_helper'

describe 'Top Districts' do
  let!(:deals) {
    100.times do |i| 
      d = Deal.create(:title => "Deal D1 #{i}", :original_id => "D1/#{i}", :source => "LivingSocial", :price_cents => 100, :division_name => 'D1')
      d.purchases.create(:quantity => 100)
    end

    50.times do |i|
      d = Deal.create(:title => "Deal D2 #{i}", :original_id => "D2/#{i}", :source => "LivingSocial", :price_cents => 100, :division_name => 'D2')
      d.purchases.create(:quantity => 100)
    end
  }

  it 'returns the best district' do
    TopDistricts.compute(Deal.all).first[0].should == 'D1'
  end

  it 'returns the valid revenue for the district' do
    TopDistricts.compute(Deal.all).first[1].should == 1000000
  end

  it 'returns all the districts' do
    TopDistricts.compute(Deal.all).count.should == 2
  end
end