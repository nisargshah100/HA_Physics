require 'spec_helper'

describe Deal do

  describe ".active" do
    let!(:active_deal)       { FactoryGirl.create(:active_deal) }
    let!(:expired_deal)      { FactoryGirl.create(:expired_deal) }

    it "Should return all active deals" do
      Deal.active.should include active_deal
    end
  end

  describe ".most_popular" do
    let!(:active_deal)       { FactoryGirl.create(:active_deal) }
    let!(:popular_deal)      { FactoryGirl.create(:popular_deal) }    

    it "Should return all deals sorted by last purchase count" do
      Deal.most_popular.should == [popular_deal, active_deal]
    end
  end

  describe ".near_user(user)" do
    let!(:close_deal)       { FactoryGirl.create(:active_deal) }
    let!(:far_deal)         { FactoryGirl.create(:cali_deal) }    
    let!(:user)             { FactoryGirl.create(:straight_male_user)}

    it "Should return all deals sorted by last purchase count" do
      Deal.near_user(user) == [ close_deal ]
    end
  end

end