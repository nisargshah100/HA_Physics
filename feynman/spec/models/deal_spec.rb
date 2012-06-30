require 'spec_helper'

describe Deal do
  describe ".livingsocial_deals" do
    it "should return all livingsocial deals" do
      Deal.should_receive(:where).with(:source => "LivingSocial")
      Deal.livingsocial_deals
    end
  end

  describe ".groupon_deals" do
    it "should return all groupon deals" do
      Deal.should_receive(:where).with(:source => "groupon")
      Deal.groupon_deals
    end
  end
end
