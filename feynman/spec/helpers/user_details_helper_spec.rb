require 'spec_helper'

describe UserDetailsHelper do
  describe "#make_hash" do
    context "given an array of values" do
      let(:values) { ["a", "b", "c"] }
      it "should return a hash with integer keys and values matching the parameters" do
        helper.make_hash(values).should == { "0" => "a", "1" => "b", "2" => "c" }
      end
    end
  end

  METHOD_NAMES = [:get_children_preferences, :get_races, :get_faiths, 
                  :get_political_affiliations, :get_educations]

  METHOD_NAMES.each do |name|
    describe "##{name}" do
      it "should call make_hash" do
        helper.should_receive(:make_hash)
        helper.send(name.to_sym)
      end
    end
  end
end
