require 'spec_helper'

describe 'Events API', :type => :api do
  context "Fetching all events through the API" do
    describe "When valid parameters are passed in" do
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

      it "should return all events of compatible users" do
        pending("Works when you run individually. Unclear why it doesn't run with the suite.")
        get "#{api_v1_events_url}.json", token: user.authentication_token
        JSON.parse(response.body).count.should == compatible_user.events.count
      end

      it "should return a successful response" do
        get "#{api_v1_events_url}.json", token: user.authentication_token
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