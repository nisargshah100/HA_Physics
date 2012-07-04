require 'spec_helper'

describe Event do
  describe ".created_by" do
    context "Given a user_id" do
      context "And that user does not exist" do
        it "should return nil" do
          Event.created_by(1).nil?.should == true
        end
      end
  
      context "And that user exists" do
        let(:event) { FactoryGirl.build(:event) }
        it "should return all events owned by the user" do
          user = double
          Event.should_receive(:created_by_users).with([1]).and_return([event])

          Event.created_by(1).should == [event]
        end
      end
    end
  end
end
