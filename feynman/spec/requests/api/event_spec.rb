require 'spec_helper'

describe 'Events API', :type => :api do
  let!(:user) do
  FactoryGirl.create(:straight_female_user) do |user|
      FactoryGirl.create(:event, user: user)
    end
  end

  let!(:compatible_user) do
    FactoryGirl.create(:straight_male_user) do |user|
      FactoryGirl.create(:event, user: user)
    end
  end
  # let(:event) { FactoryGirl.build(:event) }

  context "Fetching all events through the API" do
    describe "When valid parameters are passed in" do
      before(:each) { get "#{api_v1_events_url}.json", token: user.authentication_token }

      it "Should return all events of compatible users" do
        JSON.parse(response.body).count.should == compatible_user.events.count
      end

      it "Should return a successful response" do
        response.status.should == 200
      end
    end
  end

  # context "creating messages through the api" do
  #   let(:message) { FactoryGirl.build(:message) }
  #   let(:url) { "http://api.hungrlr.dev/v1/feeds/#{user.display_name}/growls" }

  #   describe "when valid parameters are passed in" do
  #     it "returns a successful response" do
  #       post "#{url}.json", token: user.authentication_token, body: { type: "Message", comment: message.comment }.to_json
  #       last_response.status.should == 201
  #       user.messages.last.comment.should == message.comment
  #     end
  #   end

  #   describe "when invalid parameters are passed in" do
  #     it "returns a unsuccessful response" do
  #       post "#{url}.json", token: user.authentication_token, body: { type: "Message" }.to_json
  #       last_response.status.should == 406
  #       last_response.body.should =~ /"You must provide a message."/
  #     end
  #   end
  # end
end