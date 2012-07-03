require 'spec_helper'

describe 'DealRunProbability' do
  let!(:deals) do
    [-6, -4, -2].each do |i|
      Deal.create(:title => "Deal #{i}", :original_id => i, :date_added => "#{DateTime.now + i}")
    end
  end

  it 'has a correct slope' do
    DealRunProbability.compute_slope(Deal.all).should == 2
  end

  it 'should run today' do
    DealRunProbability.compute(Deal.all, DateTime.now).first == true
  end

  it 'shouldnt run tomorrow' do
    DealRunProbability.compute(Deal.all, DateTime.now + 1).first == false
  end
end