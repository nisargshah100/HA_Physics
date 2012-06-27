require 'spec_helper'

describe 'Deal' do
  let!(:deals) {
    300.times { |i| Deal.create(:title => "LS Deal #{i}", :source => "LivingSocial") }
    200.times { |i| Deal.create(:title => "Groupon Deal #{i}", :source => "groupon") }
  }

  it 'returns valid livingsocial deals' do
    Deal.livingsocial_deals.count == 300
  end

  it 'returns valid groupon deals' do
    Deal.groupon_deals.count == 200
  end
end