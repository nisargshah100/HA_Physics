require 'spec_helper'

describe 'Deal Velocity' do
  let(:deal_1) do
    d = Deal.create(:title => "Deal 1", :date_added => DateTime.now - 1, :price_cents => 3000, :original_id => "1")
    d.purchases.create(:quantity => 10)
  end

  let(:deal_2) do
    d = Deal.create(:title => 'Deal 2', :date_added => DateTime.now - 2, :price_cents => 3000, :original_id => '2')
    d.purchases.create(:quantity => 10)
  end

  let(:deal_3) do
    d = Deal.create(:title => "Deal 3", :date_added => DateTime.now - 1, :price_cents => 3000, :original_id => '3')
    d.purchases.create(:quantity => 20)
  end

  it 'returns the deals sorted by velocity based on time' do
    deal_1
    deal_2

    velocity = DealVelocity.compute(Deal.all)
    velocity.first[1].title.should == 'Deal 1'
    velocity.last[1].title.should == 'Deal 2'
  end

  it 'returns deals sorted by the velocity based on quantity' do
    deal_1
    deal_3

    velocity = DealVelocity.compute(Deal.all)
    velocity.first[1].title.should == 'Deal 3'
    velocity.last[1].title.should == 'Deal 1'
  end

  it 'returns deals sorted by velocity based on quantity and time' do
    deal_1
    deal_2
    deal_3

    velocity = DealVelocity.compute(Deal.all)
    velocity.first[1].title.should == 'Deal 3'
    velocity[1][1].title.should == 'Deal 1'
    velocity.last[1].title.should == 'Deal 2'
  end
end