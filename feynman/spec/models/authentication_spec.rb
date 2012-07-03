require 'spec_helper'

describe Authentication do
  describe ".create_instagram" do
    context "given the oAuth data structure" do
      let(:user) { double }
      let(:data) { double }

      it "should create an authentication for the user" do
        Authentication.stub(:get_params_hash) { {} }
        Authentication.should_receive(:create).with({})
        Authentication.create_instagram(user, data)        
      end

      it "should get the params hash" do
        Authentication.should_receive(:get_params_hash).with(user, data)
        Authentication.create_instagram(user, data)        
      end
    end

    describe ".get_params_hash" do
      let(:user) { double }
      let(:data) { { "provider" => "instagram" } }
      
      it "should try to build the params hash from the oAuth data" do
        Authentication.should_receive(:params_hash_from_instagram).with(data).and_return({})
        Authentication.get_params_hash(user, data)
      end

      it "should merge the user with the formed params hash" do
        Authentication.stub(:params_hash_from_instagram) { Hash.new }
        Authentication.get_params_hash(user, data).should == { user: user }
      end
    end
  end
end
