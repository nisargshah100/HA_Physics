require 'spec_helper'

describe 'Deal' do
  let!(:deals) {
    100.times { |i| Deal.create(:title => "LS Deal #{i}", :source => "LivingSocial") }
    50.times { |i| Deal.create(:title => "Groupon Deal #{i}", :source => "groupon") }
  }

  it 'returns valid livingsocial deals' do
    Deal.livingsocial_deals.count == 100
  end

  it 'returns valid groupon deals' do
    Deal.groupon_deals.count == 50
  end
end