require 'spec_helper'

describe 'Events API', :type => :api do
  let(:user) { FactoryGirl.create(:user) }
  # let(:event) { FactoryGirl.build(:event) }
  let(:root_url) { "http://feynman.dev" }

  context "Creating an event through the API" do
    describe "When valid parameters are passed in" do
      it "Should create an event" do
        expect{ post "#{api_v1_events_url}", authentication_token: user.authentication_token, event: "{}" }.to change{ user.events.count }.by(1)
      end

      it "Should return a successful response" do
        post "#{api_v1_events_url}", authentication_token: user.authentication_token, event: "{}"
        response.status.should == 201
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